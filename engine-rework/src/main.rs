use dotenvy::dotenv;
use std::env;
use std::sync::Arc;
use tonic::transport::Server;

use api::environment_server::EnvironmentServer;
use api::project_crud_server::ProjectCrudServer;
use api::runners_server::RunnersServer;

use environment::grpc::EnvironmentImpl;
use project::grpc::ProjectCRUDImpl;
use runners::grpc::RunnersImpl;

mod common;
mod environment;
mod persistence;
mod process;
mod project;
mod runners;

pub mod api {
    tonic::include_proto!("api");
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenv().ok();
    let ipc_port = env::var("IPC_PORT").unwrap_or_else(|_| "50051".to_string());
    let addr = format!("[::1]:{}", ipc_port).parse()?;
    let db_pool = Arc::new(persistence::storage::establish_connection());
    let process_manager = Arc::new(process::process_manager::ProcessManager::new());

    let enviroment_service = EnvironmentImpl {
        process_manager: Arc::clone(&process_manager),
        db_pool: Arc::clone(&db_pool),
    };
    let node_js_info_service = RunnersImpl::new(Arc::clone(&db_pool), Arc::clone(&process_manager));
    let apps_service = ProjectCRUDImpl {
        db_pool: Arc::clone(&db_pool),
    };

    Server::builder()
        .add_service(ProjectCrudServer::new(apps_service))
        .add_service(RunnersServer::new(node_js_info_service))
        .add_service(EnvironmentServer::new(enviroment_service))
        .serve(addr)
        .await?;
    Ok(())
}
