use crate::enviroment::grpc::EnvironmentImpl;
use crate::project::grpc::AppsImpl;
use api::apps_server::AppsServer;
use api::environment_server::EnvironmentServer;
use std::sync::Arc;
use tonic::transport::Server;

mod enviroment;
mod project;
mod schema;
mod storage;

pub mod api {
    tonic::include_proto!("api");
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "[::1]:50051".parse()?;
    let db_pool = Arc::new(storage::establish_connection());
    let enviroment_service = EnvironmentImpl::default();
    let apps_service = AppsImpl {
        db_pool: Arc::clone(&db_pool),
    };

    Server::builder()
        .add_service(EnvironmentServer::new(enviroment_service))
        .add_service(AppsServer::new(apps_service))
        .serve(addr)
        .await?;
    Ok(())
}
