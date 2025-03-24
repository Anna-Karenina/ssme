use crate::persistence::get_temp_path;
use crate::runners::utils::{deserialize_empty_as_none, deserialize_lts};
use crate::{api::DownloadStatusResponse, common::arch::Arch};

use async_compression::tokio::bufread::GzipDecoder;
use futures_util::StreamExt;

use async_tar::Archive;
use reqwest::{Client, Response, Url};
use serde::Deserialize;
use std::collections::HashMap;
use std::path::Path;
use std::sync::Arc;
use tokio::fs::{self, File};
use tokio::io::AsyncWriteExt;
use tokio::sync::{Mutex, mpsc, watch};
use tokio_util::compat::TokioAsyncReadCompatExt;
use tokio_util::io::ReaderStream;
use tonic::Status;

#[derive(Deserialize, Debug)]
pub struct Node {
    pub version: String,
    #[serde(skip_deserializing)]
    pub date: String,
    files: Vec<String>,
    #[serde(deserialize_with = "deserialize_empty_as_none")]
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
    abort_sender: Arc<Mutex<watch::Sender<bool>>>,
}

impl NodeJsOrgClient {
    pub fn new() -> Self {
        let (abort_sender, _) = watch::channel(false);
        Self {
            base_url: Url::parse("https://nodejs.org/dist").unwrap(),
            abort_sender: Arc::new(Mutex::new(abort_sender)),
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
        let base_source_path = format!("{}/tmp/nodes", get_temp_path().to_string_lossy());
        let temp_path = format!(
            "{}/tmp/ssme/{}",
            get_temp_path().to_string_lossy(),
            file_name
        );
        let source_path = format!("{}/{}", base_source_path, version);
        let abort_rx = self.get_abort_receiver().await; // uses for thread safe abort downloading

        if let Err(e) = NodeJsOrgClient::ensure_directory_exists(&base_source_path).await {
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
                status: format!("Starting dowload: {}", url),
            }))
            .await
            .is_err()
        {
            return;
        };

        if let Err(e) = self.download_file(&url, &temp_path, &tx, abort_rx).await {
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
                status: format!("Download completed, into: {} starting unpack", &temp_path),
            }))
            .await
            .is_err()
        {
            return;
        };

        if let Err(e) = NodeJsOrgClient::extract_tar_gz(&temp_path, &source_path).await {
            let _ = tx
                .send(Err(Status::internal(format!("Unpack failed: {}", e))))
                .await;
            return;
        }

        if let Err(e) = self.delete_archive(&temp_path).await {
            let _ = tx
                .send(Err(Status::internal(format!("Clean up failed: {}", e))))
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
        abort_rx: watch::Receiver<bool>,
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

    pub async fn cancel_download(&self) {
        let abort_sender = self.abort_sender.lock().await;
        let _ = abort_sender.send(true);
    }

    async fn extract_tar_gz(
        file_path: &str,
        extract_path: &str,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        let file = File::open(file_path).await.map_err(|e| {
            eprintln!("Failed to open file {}: {}", file_path, e);
            e
        })?;

        let tar_file_name = Path::new(file_path).file_name().ok_or_else(|| {
            let err = format!("Failed to extract file name from path: {}", file_path);
            eprintln!("{}", err);
            err
        })?;

        let reader = ReaderStream::new(file);
        let stream_reader = tokio_util::io::StreamReader::new(reader);

        let decoder = GzipDecoder::new(stream_reader);
        let archive = Archive::new(decoder.compat());

        let extract_path_as_path = Path::new(extract_path);

        let version_dir_name = extract_path_as_path
            .file_name()
            .ok_or_else(|| {
                let err = format!(
                    "Failed to extract version directory name from path: {}",
                    extract_path
                );
                eprintln!("{}", err);
                err
            })?
            .to_str()
            .ok_or_else(|| {
                let err = format!(
                    "Failed to convert version directory name to string: {}",
                    extract_path
                );
                eprintln!("{}", err);
                err
            })?;

        if let Some(parent) = extract_path_as_path.parent() {
            archive.unpack(parent).await.map_err(|e| {
                eprintln!("Failed to unpack archive into {}: {}", parent.display(), e);
                e
            })?;

            let extracted_dir = format!(
                "{}/{}",
                parent.display(),
                tar_file_name
                    .to_string_lossy()
                    .strip_suffix(".tar.gz")
                    .unwrap()
                    .to_string()
            );
            let target_dir = format!("{}/{}", parent.display(), version_dir_name);

            fs::rename(&extracted_dir, &target_dir).await.map_err(|e| {
                eprintln!(
                    "Failed to rename extracted directory from {} to {}: {}",
                    extracted_dir, target_dir, e
                );
                e
            })?;
        } else {
            let err = format!(
                "Failed to determine parent directory for path: {}",
                extract_path
            );
            eprintln!("{}", err);
            return Err(err.into());
        }

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

    async fn get_abort_receiver(&self) -> watch::Receiver<bool> {
        self.abort_sender.lock().await.subscribe()
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

    async fn ensure_directory_exists(
        path: &str,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        let path = Path::new(path);
        if !path.exists() {
            fs::create_dir_all(path).await?;
        }
        Ok(())
    }

    async fn delete_archive(
        &self,
        archive_path: &str,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        if let Err(e) = tokio::fs::remove_file(archive_path).await {
            eprintln!("Archive delete failure {}: {}", archive_path, e);
        }
        Ok(())
    }
}
