use std::sync::Arc;

use tokio::sync::mpsc;
use tokio_stream::wrappers::ReceiverStream;
use tonic::{Request, Response, Status};

use crate::api;
use crate::environment::worker::EnvironmentWorker;

use crate::persistence::storage::DbPool;

use super::nodejs_org_client::NodeJsOrgClient;

pub struct RunnersImpl {
    pub db_pool: Arc<DbPool>,
    node_js_org_client: Arc<NodeJsOrgClient>,
}

impl RunnersImpl {
    pub fn new(db_pool: Arc<DbPool>) -> Self {
        Self {
            db_pool,
            node_js_org_client: Arc::new(NodeJsOrgClient::new()),
        }
    }
}
#[tonic::async_trait]
impl api::runners_server::Runners for RunnersImpl {
    async fn get_all_node_js_versions(
        &self,
        request: Request<api::GetAllNodeJsVersionsParams>,
    ) -> Result<Response<api::NodeJsVersionsInfo>, Status> {
        let req = request.into_inner();

        let api_versions = self
            .node_js_org_client
            .fetch_node_list(req.lts_only, req.latest_only)
            .await
            .map_err(|e| Status::internal(format!("Failed to fetch Node.js versions: {:?}", e)))?;

        let installed_versions = EnvironmentWorker::check_installed_node_js_version()
            .await
            .map_err(|e| {
                Status::internal(format!(
                    "Failed to parse installed Node.js versions: {:?}",
                    e
                ))
            })?;

        let response = api_versions
            .into_iter()
            .map(|v| api::NodeJsVersionInfo {
                installed: installed_versions.contains(&v.version),
                lts: v.lts,
                version: v.version,
            })
            .collect();

        Ok(Response::new(api::NodeJsVersionsInfo {
            node_js_info: response,
        }))
    }

    type DownloadNodeJsVersionStream =
        tokio_stream::wrappers::ReceiverStream<Result<api::DownloadStatusResponse, Status>>;

    async fn download_node_js_version(
        &self,
        request: Request<api::RequestVersion>,
    ) -> Result<Response<Self::DownloadNodeJsVersionStream>, Status> {
        let req = request.into_inner();
        let (tx, rx) = mpsc::channel(10);
        let client = self.node_js_org_client.clone();

        tokio::spawn(async move {
            client
                .download_specific_node_js_version(req.version.to_string(), tx)
                .await
        });

        Ok(Response::new(ReceiverStream::new(rx)))
    }

    async fn abort_download_node_js_version(
        &self,
        _request: Request<api::EmptyParams>,
    ) -> Result<Response<api::EmptyParams>, Status> {
        self.node_js_org_client.cancel_download().await;
        Ok(Response::new(api::EmptyParams {}))
    }
}
// "https://nodejs.org/dist/node-v18.19.0-darwin-arm64.tar.gz"
// "https://nodejs.org/download/release/v18.19.0/node-v18.19.0-darwin-arm64.tar.gz
