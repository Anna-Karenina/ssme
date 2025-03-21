use tonic::Status;

use crate::api;

#[derive(Default)]
pub struct EnvironmentImpl;

#[tonic::async_trait]
impl api::environment_server::Environment for EnvironmentImpl {
    type ProcessStreamStream =
        tokio_stream::wrappers::ReceiverStream<Result<api::ProcessInfo, Status>>;

    async fn process_stream(
        &self,
        _request: tonic::Request<api::DataRequest>,
    ) -> Result<tonic::Response<Self::ProcessStreamStream>, Status> {
        let (_, rx) = tokio::sync::mpsc::channel(4);
        let stream = tokio_stream::wrappers::ReceiverStream::new(rx);
        Ok(tonic::Response::new(stream))
    }

    async fn get_nodejs_info(
        &self,
        _request: tonic::Request<api::EmptyParams>,
    ) -> Result<tonic::Response<api::NodejsVersionsInfo>, Status> {
        Ok(tonic::Response::new(api::NodejsVersionsInfo::default()))
    }

    async fn update_default_nodejs_version(
        &self,
        _request: tonic::Request<api::UpdateDefaultNodejsVersionParams>,
    ) -> Result<tonic::Response<api::StatusResponse>, Status> {
        Ok(tonic::Response::new(api::StatusResponse::default()))
    }

    type DownloadNodeJsVersionStream =
        tokio_stream::wrappers::ReceiverStream<Result<api::DownloadStatusResponse, Status>>;

    async fn download_node_js_version(
        &self,
        _request: tonic::Request<api::RequestVersion>,
    ) -> Result<tonic::Response<Self::DownloadNodeJsVersionStream>, Status> {
        let (_, rx) = tokio::sync::mpsc::channel(4);
        let stream = tokio_stream::wrappers::ReceiverStream::new(rx);
        Ok(tonic::Response::new(stream))
    }
}
