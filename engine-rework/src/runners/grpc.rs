use tonic::{Request, Response, Status};

use crate::api;
use crate::environment::worker::EnvironmentWorker;

use crate::persistence::storage::DbPool;

use super::nodejs_org_client::NodeJsOrgClient;
pub struct RunnersImpl {
    pub db_pool: std::sync::Arc<DbPool>,
    node_js_org_client: NodeJsOrgClient,
}

impl RunnersImpl {
    pub fn new(db_pool: std::sync::Arc<DbPool>) -> Self {
        Self {
            db_pool,
            node_js_org_client: NodeJsOrgClient::new(),
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
}
