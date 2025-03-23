use crate::environment::grpc::EnvironmentImpl;
use crate::project::grpc::AppsImpl;
use api::apps_server::AppsServer;
use api::environment_server::EnvironmentServer;
use api::runners_server::RunnersServer;

use runners::grpc::RunnersImpl;
use std::sync::Arc;
use tonic::transport::Server;

mod common;
mod environment;
mod persistence;
mod project;
mod runners;

pub mod api {
    tonic::include_proto!("api");
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "[::1]:50051".parse()?;
    let db_pool = Arc::new(persistence::storage::establish_connection());
    let enviroment_service = EnvironmentImpl::default();
    let node_js_info_service = RunnersImpl::new(Arc::clone(&db_pool));
    let apps_service = AppsImpl {
        db_pool: Arc::clone(&db_pool),
    };

    Server::builder()
        .add_service(EnvironmentServer::new(enviroment_service))
        .add_service(AppsServer::new(apps_service))
        .add_service(RunnersServer::new(node_js_info_service))
        .serve(addr)
        .await?;
    Ok(())
}
