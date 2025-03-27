use std::time::Duration;

use super::progress_reporter::ProgressReporter;
use futures_util::StreamExt;

use tokio::{io::AsyncWriteExt, time::interval};

use thiserror::Error;
use tokio_util::sync::CancellationToken;

#[derive(Debug, Error)]
pub enum DownloadError {
    #[error("Download aborted")]
    Aborted,

    #[error("Download failed with message: {0}")]
    Failed(String),

    #[error("Unknown error occurred")]
    Unknown,
}

pub struct Downloader {
    client: reqwest::Client,
    cancel_token: CancellationToken,
}

impl Downloader {
    pub fn new(client: reqwest::Client) -> Self {
        Self {
            client,
            cancel_token: CancellationToken::new(),
        }
    }

    pub fn cancel(&self) {
        self.cancel_token.cancel();
    }

    pub async fn download<R: ProgressReporter + Send + Sync>(
        &self,
        url: &str,
        file_path: &str,
        reporter: &R,
    ) -> Result<(), DownloadError> {
        let child_token = self.cancel_token.clone();

        let response =
            match tokio::time::timeout(Duration::from_secs(1), self.client.get(url).send()).await {
                Ok(Ok(res)) => res,
                Ok(Err(e)) => return Err(DownloadError::Failed(format!("Request failed: {}", e))),
                Err(_) => return Err(DownloadError::Failed("Request timeout".to_string())),
            };

        let total_size = response.content_length().ok_or(DownloadError::Failed(
            "Failed to get content length".to_string(),
        ))?;

        let mut file = tokio::fs::File::create(file_path)
            .await
            .map_err(|e| DownloadError::Failed(format!("Failed to create file: {}", e)))?;

        let mut stream = response.bytes_stream();
        let mut downloaded: u64 = 0;
        let mut last_reported_percent = 0;
        let mut throttle = interval(Duration::from_millis(5));

        while let Some(item) = stream.next().await {
            if child_token.is_cancelled() {
                tokio::fs::remove_file(file_path).await.ok();
                reporter
                    .report_error("Download aborted by user".to_string())
                    .await;
                return Err(DownloadError::Aborted);
            }

            let chunk =
                item.map_err(|e| DownloadError::Failed(format!("Failed to read chunk: {}", e)))?;

            throttle.tick().await; // Fucking magic! throttle write operation 

            tokio::select! {
                _ = child_token.cancelled() => {
                    tokio::fs::remove_file(file_path).await.ok();
                    reporter.report_error("Download aborted during write".to_string()).await;
                    return Err(DownloadError::Aborted);
                },
                res = file.write_all(&chunk) => {
                    res.map_err(|e| DownloadError::Failed(format!("Failed to write to file: {}", e)))?
                }
            };

            downloaded += chunk.len() as u64;
            let percent = ((downloaded as f64 / total_size as f64) * 100.0).round() as u64;
            if percent > last_reported_percent {
                last_reported_percent = percent;
                reporter
                    .report_progress(format!("Downloaded [{}]%", percent))
                    .await;
            }
        }

        file.flush()
            .await
            .map_err(|e| DownloadError::Failed(format!("Failed to flush file: {}", e)))?;

        // Verify download size
        let actual_size = tokio::fs::metadata(file_path)
            .await
            .map_err(|e| DownloadError::Failed(format!("Failed to get metadata: {}", e)))?
            .len();

        if actual_size != total_size {
            tokio::fs::remove_file(file_path).await.ok();
            return Err(DownloadError::Failed(format!(
                "Download size mismatch: expected {}, got {}",
                total_size, actual_size
            )));
        }

        reporter
            .report_progress("Download completed successfully".to_string())
            .await;
        Ok(())
    }
}
