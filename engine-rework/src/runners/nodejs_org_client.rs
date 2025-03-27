use crate::common::downloader::DownloadError;
use crate::common::{downloader::Downloader, progress_reporter::ProgressReporter};
use crate::persistence::get_temp_path;

use crate::runners::utils::deserialize_lts;

use crate::common::arch::Arch;

use async_compression::tokio::bufread::GzipDecoder;

use async_tar::Archive;
use reqwest::header::{HeaderMap, USER_AGENT};
use reqwest::{Client, Url};
use serde::Deserialize;
use std::collections::HashMap;
use std::path::Path;
use std::sync::Arc;
use tokio::fs::{self, File};
use tokio::sync::Mutex;
use tokio_util::compat::TokioAsyncReadCompatExt;
use tokio_util::io::ReaderStream;
use tonic::Status;

#[allow(dead_code)]
#[derive(Deserialize, Debug)]
pub struct Node {
    pub version: String,
    #[serde(skip_deserializing)]
    pub date: String,
    files: Vec<String>,
    #[serde(default)]
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
    active_downloads: Arc<Mutex<HashMap<String, Arc<Downloader>>>>,
    http_client: Client,
}

impl NodeJsOrgClient {
    pub fn new() -> Self {
        let mut headers = HeaderMap::new();
        headers.insert(
            USER_AGENT,
            concat!("ssme ", env!("CARGO_PKG_VERSION"))
                .parse()
                .expect("heaader build err"),
        );
        let http_client = Client::builder()
            .default_headers(headers)
            .build()
            .expect("http client build err");

        Self {
            base_url: Url::parse("https://nodejs.org/dist").unwrap(),
            active_downloads: Arc::new(Mutex::new(HashMap::new())),
            http_client,
        }
    }

    pub async fn fetch_node_list(
        &self,
        lts_only: bool,
        latest_only: bool,
    ) -> Result<Vec<Node>, Box<dyn std::error::Error + Send + Sync>> {
        let url = format!("{}/index.json", self.base_url);
        let response = self.http_client.get(url).send().await?;
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
        reporter: impl ProgressReporter + Send + Sync,
    ) {
        let file_name = Self::filename_for_version(version.to_owned(), "tar.gz");
        let url = format!("{}/{}/{}", &self.base_url, version, file_name);
        let base_source_path = format!("{}/tmp/nodes", get_temp_path().to_string_lossy());
        let archive_file_path = format!("{}/{}", &base_source_path, file_name);
        let target_path = format!("{}/{}", &base_source_path, version);

        let downloader = Arc::new(Downloader::new(self.http_client.clone()));

        self.active_downloads
            .lock()
            .await
            .insert(version.clone(), Arc::clone(&downloader));

        if let Err(e) = Self::ensure_directory_exists(&base_source_path).await {
            reporter
                .report_error(format!("Failed to create directories: {}", e))
                .await;
            return;
        }

        reporter
            .report_progress(format!(
                "Starting download of Node.js {} into {}",
                version, &base_source_path
            ))
            .await;

        match downloader
            .download(&url, &archive_file_path, &reporter)
            .await
        {
            Ok(_) => {
                reporter
                    .report_progress("Download complete, extracting files...".to_string())
                    .await;

                if let Err(e) = Self::extract_tar_gz(&archive_file_path, &target_path).await {
                    let _ = tokio::fs::remove_dir_all(&target_path).await;
                    reporter
                        .report_error(format!("Extraction failed: {}", e))
                        .await;
                    return;
                }

                if let Err(e) = tokio::fs::remove_file(&archive_file_path).await {
                    reporter
                        .report_error(format!("Failed to clean up archive: {}", e))
                        .await;
                    // Not fatal - continue
                }

                let node_binary_path = Path::new(&target_path).join("bin/node");
                if !node_binary_path.exists() {
                    reporter
                        .report_error(
                            "Extracted files are invalid - missing node binary".to_string(),
                        )
                        .await;
                    return;
                }

                reporter
                    .report_progress(format!(
                        "Successfully installed Node.js {} into {}",
                        version, target_path
                    ))
                    .await;
            }
            Err(DownloadError::Aborted) => {
                reporter.report_progress(format!("Download aborted")).await;
            }
            Err(e) => {
                reporter
                    .report_error(format!("Download failed: {}", e))
                    .await;
                return;
            }
        }
    }

    pub async fn stop_download(&self, download_id: &str) -> Result<(), Status> {
        let mut downloads = self.active_downloads.lock().await;

        if let Some(downloader) = downloads.remove(download_id) {
            downloader.cancel();
            Ok(())
        } else {
            Err(Status::not_found(format!(
                "Download with ID {} not found or already completed",
                download_id
            )))
        }
    }
    async fn extract_tar_gz(
        path_to_arhive: &str,
        extract_path: &str,
    ) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
        let file = File::open(path_to_arhive).await.map_err(|e| {
            let err = format!("Failed to open file {}: {}", path_to_arhive, e);
            eprintln!("{}", err);
            err
        })?;

        let tar_file_name = Path::new(path_to_arhive)
            .file_name()
            .ok_or_else(|| {
                let err = format!("Failed to extract file name from path: {}", path_to_arhive);
                eprintln!("{}", err);
                err
            })?
            .to_string_lossy()
            .into_owned();

        let reader = ReaderStream::new(file);
        let stream_reader = tokio_util::io::StreamReader::new(reader);
        let decoder = GzipDecoder::new(stream_reader);
        let archive = Archive::new(decoder.compat());

        let extract_path_as_path = Path::new(extract_path);
        let parent = extract_path_as_path.parent().ok_or_else(|| {
            let err = format!(
                "Failed to determine parent directory for path: {}",
                extract_path
            );
            eprintln!("{}", err);
            err
        })?;

        archive.unpack(parent).await.map_err(|e| {
            let err = format!(
                "Failed to unpack archive into {}: {} (file: {})",
                parent.display(),
                e,
                path_to_arhive
            );
            eprintln!("{}", err);
            err
        })?;

        let stripped_name = tar_file_name
            .strip_suffix(".tar.gz")
            .unwrap_or(&tar_file_name);
        let extracted_dir = format!("{}/{}", parent.display(), stripped_name);
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

        let target_dir = format!("{}/{}", parent.display(), version_dir_name);

        if tokio::fs::metadata(&extracted_dir).await.is_ok() {
            tokio::fs::rename(&extracted_dir, &target_dir)
                .await
                .map_err(|e| {
                    let err = format!(
                        "Failed to rename extracted directory from {} to {}: {}",
                        extracted_dir, target_dir, e
                    );
                    eprintln!("{}", err);
                    err
                })?;
        } else {
            eprintln!(
                "Warning: Extracted directory {} doesn't exist, skipping rename",
                extracted_dir
            );
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
}
