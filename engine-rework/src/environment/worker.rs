pub struct EnvironmentWorker;

impl EnvironmentWorker {
    pub async fn check_installed_node_js_version() -> Result<Vec<String>, Box<dyn std::error::Error>>
    {
        Ok(vec![String::from("v18.20.7")])
    }
}
