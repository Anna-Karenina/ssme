#[async_trait::async_trait]
pub trait ProgressReporter {
    async fn report_progress(&self, message: String);
    async fn report_error(&self, error: String);
}
