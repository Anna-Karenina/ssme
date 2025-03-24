use std::sync::Arc;

use crate::persistence::get_temp_path;
use crate::process::process_manager::ProcessManager;
use crate::project::repository::get_project;
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
    pub process_manager: std::sync::Arc<ProcessManager>,
}

impl RunnersImpl {
    pub fn new(db_pool: Arc<DbPool>, process_manager: Arc<ProcessManager>) -> Self {
        Self {
            db_pool,
            node_js_org_client: Arc::new(NodeJsOrgClient::new()),
            process_manager,
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

    async fn run_app(
        &self,
        request: Request<api::RunAppRequest>,
    ) -> Result<Response<api::AppRunTime>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to acquire a database connection"))?;

        let req = request.into_inner();
        let project = get_project(conn, req.id)
            .map_err(|e| Status::not_found(format!("grpc error: {}", e)))?;

        let node_path = format!(
            "{}/tmp/ssme/nodes/{}/bin/node",
            get_temp_path().to_string_lossy(),
            project.node_version.unwrap()
        );
        let js_file_path =
            "/Users/annakarenina/develop/github.com/Anna-Karenina/ssme/engine-rework/test.js";

        if let Err(err) = self
            .process_manager
            .start_process(project.id, &node_path, &[&js_file_path])
            .await
        {
            return Err(Status::internal(format!(
                "Failed to start process: {}",
                err
            )));
        }

        Ok(Response::new(api::AppRunTime::default()))
    }

    async fn stop_app(
        &self,
        request: Request<api::AppIdPayload>,
    ) -> Result<Response<api::AppRunTime>, Status> {
        if let Err(err) = self
            .process_manager
            .stop_process(request.into_inner().id)
            .await
        {
            return Err(Status::internal(format!("Failed to stop process: {}", err)));
        };

        Ok(Response::new(api::AppRunTime::default()))
    }
}
