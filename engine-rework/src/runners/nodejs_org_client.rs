use crate::runners::utils::deserialize_lts;
use crate::{api::DownloadStatusResponse, common::arch::Arch};

use async_compression::tokio::bufread::GzipDecoder;
use futures_util::StreamExt;

use async_tar::Archive;
use reqwest::{Client, Response, Url};
use serde::Deserialize;
use std::collections::HashMap;
use tokio::fs::File;
use tokio::io::AsyncWriteExt;
use tokio::sync::{mpsc, watch};
use tokio_util::compat::TokioAsyncReadCompatExt;
use tokio_util::io::ReaderStream;
use tonic::Status;

#[derive(Deserialize, Debug)]
pub struct Node {
    pub version: String,
    #[serde(skip_deserializing)]
    pub date: String,
    files: Vec<String>,
    // #[serde(deserialize_with = "deserialize_empty_as_none")]
    #[serde(skip_deserializing)]
    npm: Option<String>,
    #[serde(skip_deserializing)]
    v8: String,
    #[serde(skip_deserializing)]
    uv: String,
    #[serde(skip_deserializing)]
    zlib: String,
    #[serde(skip_deserializing)]
    openssl: String,
    #[serde(skip_deserializing)]
    modules: String,
    #[serde(deserialize_with = "deserialize_lts")]
    pub lts: bool,
    #[serde(skip_deserializing)]
    security: bool,
}

pub struct NodeJsOrgClient {
    base_url: Url,
    abort_sender: watch::Sender<bool>,
}

impl NodeJsOrgClient {
    pub fn new() -> Self {
        let (abort_sender, _) = watch::channel(false);
        Self {
            base_url: Url::parse("https://nodejs.org/dist").unwrap(),
            abort_sender,
        }
    }

    pub async fn fetch_node_list(
        &self,
        lts_only: bool,
        latest_only: bool,
    ) -> Result<Vec<Node>, Box<dyn std::error::Error + Send + Sync>> {
        let response = self.get("/index.json").await?;
        let mut nodes: Vec<Node> = response.json().await?;

        if lts_only {
            nodes.retain(|node| node.lts);
        }
        if latest_only {
            nodes = NodeJsOrgClient::filter_latest_versions(nodes);
        }

        Ok(nodes)
    }

    pub async fn download_specific_node_js_version(
        &self,
        version: String,
        tx: mpsc::Sender<Result<DownloadStatusResponse, tonic::Status>>,
    ) {
        let file_name = NodeJsOrgClient::filename_for_version(version.to_owned(), "tar.gz");
        let url = format!("/{}/{}", version, file_name);
        let save_path = format!("/tmp/{}", file_name);
        let extract_path = format!("/tmp/{}", version);
        let abort_rx = self.get_abort_receiver(); // uses for thread safe abort downloading

        if tx
            .send(Ok(DownloadStatusResponse {
                status: format!("Starting dowload: {}", url),
            }))
            .await
            .is_err()
        {
            return;
        };

        if let Err(e) = self.download_file(&url, &save_path, &tx, abort_rx).await {
            let _ = tx
                .send(Err(tonic::Status::internal(format!(
                    "Download failed: {}",
                    e
                ))))
                .await;
            return;
        };

        if tx
            .send(Ok(DownloadStatusResponse {
                status: "Download completed, starting unpack".to_string(),
            }))
            .await
            .is_err()
        {
            return;
        };

        if let Err(e) = self.extract_tar_gz(&save_path, &extract_path).await {
            let _ = tx
                .send(Err(tonic::Status::internal(format!(
                    "Unpack failed: {}",
                    e
                ))))
                .await;
            return;
        }

        let _ = tx
            .send(Ok(DownloadStatusResponse {
                status: "Unpack complete".to_string(),
            }))
            .await;
    }

    async fn download_file(
        &self,
        url: &str,
        file_path: &str,
        tx: &mpsc::Sender<Result<DownloadStatusResponse, Status>>,
        mut abort_rx: watch::Receiver<bool>,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        let response = self.get(url).await?.error_for_status()?;
        let total_size = response
            .content_length()
            .ok_or("Failed to get content length")?;
        let mut file = tokio::fs::File::create(file_path).await?;
        let mut stream = response.bytes_stream();
        let mut downloaded: u64 = 0;
        let mut last_reported_percent = 0;

        while let Some(chunk) = stream.next().await {
            if *abort_rx.borrow() {
                let _ = tx.send(Err(Status::cancelled("Download aborted"))).await;
                return Err("Download cancelled".into());
            }

            let chunk = chunk?;
            file.write_all(&chunk).await?;
            downloaded += chunk.len() as u64;

            let percent = ((downloaded as f64 / total_size as f64) * 100.0).round() as u64;

            if percent > last_reported_percent {
                last_reported_percent = percent;
                let _ = tx
                    .send(Ok(DownloadStatusResponse {
                        status: format!("Downloaded {}%", percent),
                    }))
                    .await;
            }
        }

        file.flush().await?;
        Ok(())
    }

    pub fn cancel_download(&self) {
        let _ = self.abort_sender.send(true);
    }

    async fn extract_tar_gz(
        &self,
        file_path: &str,
        extract_path: &str,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        let file = File::open(file_path).await?;
        let reader = ReaderStream::new(file);
        let stream_reader = tokio_util::io::StreamReader::new(reader);
        let decoder = GzipDecoder::new(stream_reader);
        let archive = Archive::new(decoder.compat());
        archive.unpack(extract_path).await?;
        Ok(())
    }

    #[cfg(unix)]
    fn filename_for_version(version: String, ext: &str) -> String {
        format!(
            "node-{node_ver}-{platform}-{arch}.{ext}",
            node_ver = &version,
            platform = crate::common::system_info::platform_name(),
            arch = Arch::default(),
            ext = ext
        )
    }

    #[cfg(windows)]
    fn filename_for_version(version: String, arch: Arch, ext: &str) -> String {
        format!(
            "node-{node_ver}-win-{arch}.{ext}",
            node_ver = &version,
            arch = arch,
            ext = ext,
        )
    }

    async fn get(&self, path: &str) -> Result<Response, Box<dyn std::error::Error + Send + Sync>> {
        let url = format!("{}{}", self.base_url, path);
        let response = Client::new()
            .get(url)
            .header("User-Agent", concat!("ssme ", env!("CARGO_PKG_VERSION")))
            .send()
            .await?;

        Ok(response)
    }

    fn get_abort_receiver(&self) -> watch::Receiver<bool> {
        self.abort_sender.subscribe()
    }

    fn filter_latest_versions(versions: Vec<Node>) -> Vec<Node> {
        let mut latest_versions: HashMap<String, Node> = HashMap::new();

        for node in versions {
            if let Some(major) = node
                .version
                .strip_prefix('v')
                .and_then(|v| v.split('.').next())
            {
                let major = major.to_string();

                if let Some(existing) = latest_versions.get(&major) {
                    if node.version > existing.version {
                        latest_versions.insert(major, node);
                    }
                } else {
                    latest_versions.insert(major, node);
                }
            }
        }

        let mut result: Vec<Node> = latest_versions.into_values().collect();

        // Sorting by major, minor, patch (desc)
        result.sort_by(|a, b| {
            let parse_version = |v: &str| {
                v.strip_prefix('v')
                    .unwrap_or(v)
                    .split('.')
                    .map(|s| s.parse::<u32>().unwrap_or(0))
                    .collect::<Vec<u32>>()
            };

            let va = parse_version(&a.version);
            let vb = parse_version(&b.version);

            va.cmp(&vb).reverse()
        });

        result
    }
}
