use std::process::Command;
use tokio::sync::mpsc;
use tokio_stream::wrappers::ReceiverStream;
use tonic::{Request, Response, Status};

use crate::{
    api, persistence::storage::DbPool, process::process_manager::ProcessManager,
    project::repository::get_project,
};

pub struct EnvironmentImpl {
    pub process_manager: std::sync::Arc<ProcessManager>,
    pub db_pool: std::sync::Arc<DbPool>,
}

#[tonic::async_trait]
impl api::environment_server::Environment for EnvironmentImpl {
    type ReadProcessLogsStream =
        tokio_stream::wrappers::ReceiverStream<Result<api::ProcessLogsByLine, Status>>;

    type ReadProcessResourcesStream =
        tokio_stream::wrappers::ReceiverStream<Result<api::ResourceUsage, Status>>;

    async fn run_project_in_code(
        &self,
        request: tonic::Request<api::AppIdPayload>,
    ) -> Result<tonic::Response<api::EmptyParams>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to get DB connection"))?;
        let req = request.into_inner();

        let project = get_project(conn, req.id)
            .map_err(|e| Status::not_found(format!("grpc error: {}", e)))?;

        #[cfg(target_os = "windows")]
        {
            Command::new("code")
                .arg(&project.path)
                .spawn()
                .map_err(|_| Status::internal("Failed to start VS Code"))?;
        }

        #[cfg(target_family = "unix")]
        {
            Command::new("code")
                .arg(&project.path)
                .stdin(std::process::Stdio::null())
                .stdout(std::process::Stdio::null())
                .stderr(std::process::Stdio::null())
                .spawn()
                .map_err(|_| Status::internal("Failed to start VS Code"))?;
        }

        Ok(tonic::Response::new(api::EmptyParams::default()))
    }

    async fn read_process_resources(
        &self,
        request: Request<api::AppIdPayload>,
    ) -> Result<Response<Self::ReadProcessResourcesStream>, Status> {
        let req = request.into_inner();
        let (tx, rx) = mpsc::channel(10);
        let process_manager = self.process_manager.clone();

        tokio::spawn(async move {
            if let Err(e) = process_manager.stream_resource_usage(req.id, tx).await {
                eprintln!("Error in stream_resource_usage: {:?}", e);
            }
        });

        Ok(Response::new(ReceiverStream::new(rx)))
    }

    async fn read_process_logs(
        &self,
        request: Request<api::AppIdPayload>,
    ) -> Result<Response<Self::ReadProcessLogsStream>, Status> {
        let req = request.into_inner();
        let (tx, rx) = mpsc::channel(10);
        let process_manager = self.process_manager.clone();

        tokio::spawn(async move {
            if let Err(e) = process_manager.stream_output(req.id, tx).await {
                eprintln!("Ошибка в stream_output: {:?}", e);
            }
        });

        Ok(Response::new(ReceiverStream::new(rx)))
    }

    async fn processes_list(
        &self,
        _request: Request<api::EmptyParams>,
    ) -> Result<Response<api::ProcessesListInfoResponse>, tonic::Status> {
        let processes = self.process_manager.list_processes().await;
        Ok(Response::new(api::ProcessesListInfoResponse {
            list: processes,
        }))
    }
}
