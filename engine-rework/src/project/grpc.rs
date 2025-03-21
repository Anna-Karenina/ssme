use tonic::{Request, Response, Status};

use crate::{api, persistence::storage::DbPool};

use super::models::NewProject;
use super::repository::{
    create_project, delete_project, get_all_projects, get_project, update_project,
};
use super::worker::{PackageJsonParser, ProjectWorker};

pub struct AppsImpl {
    pub db_pool: std::sync::Arc<DbPool>,
}

#[tonic::async_trait]
impl api::apps_server::Apps for AppsImpl {
    async fn create_app(
        &self,
        request: Request<api::CreateAppPayload>,
    ) -> Result<Response<api::App>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to get DB connection"))?;
        let req = request.into_inner();
        let project_worker = ProjectWorker::new(&req.path);

        let package_json_path = project_worker
            .read_project_directory()
            .map_err(|err| Status::invalid_argument(format!("Project Worker error: {}", err)))?;

        let package_json_content = match PackageJsonParser::parse(package_json_path) {
            Ok(project) => {
                PackageJsonParser::populate_node_version(project, &project_worker.path.unwrap())
            }
            Err(err) => {
                return Err(Status::invalid_argument(format!(
                    "Project Worker error: {}",
                    err
                )));
            }
        };

        let scripts_vec = package_json_content
            .scripts
            .unwrap()
            .keys()
            .cloned()
            .collect::<Vec<String>>();

        let new_project = NewProject {
            name: &req.name,
            path: &req.path,
            node_version: package_json_content
                .engine_version
                .as_ref()
                .and_then(|engine| engine.node.as_ref())
                .ok_or_else(|| Status::invalid_argument("Missing node version"))?,
            is_app_valid: false,
            default_script: scripts_vec.first().unwrap(),
            scripts: serde_json::to_string(&scripts_vec).unwrap(),
        };

        let created_proejct = create_project(conn, new_project)
            .map_err(|e| Status::invalid_argument(format!("Create project error: {}", e)))?;
        Ok(Response::new(api::App {
            id: created_proejct.id,
            path: created_proejct.path.to_string(),
            name: created_proejct.name.to_string(),
            scripts: scripts_vec,
            node_version: created_proejct
                .node_version
                .unwrap_or_else(|| "unknown".to_string()),
            default_script: created_proejct
                .default_script
                .unwrap_or_else(|| "unknown".to_string()),
            is_app_valid: created_proejct.is_app_valid,
        }))
    }

    async fn read_app(
        &self,
        request: Request<api::AppIdPayload>,
    ) -> Result<Response<api::App>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to get DB connection"))?;
        let req = request.into_inner();
        let project = get_project(conn, req.id)
            .map_err(|e| Status::not_found(format!("grpc error: {}", e)))?;
        Ok(Response::new(api::App {
            id: project.id,
            path: project.path,
            name: project.name,
            scripts: project
                .scripts
                .as_ref()
                .map(|s| serde_json::from_str(s).unwrap_or_default())
                .unwrap_or_default(),
            node_version: project
                .node_version
                .unwrap_or_else(|| "unknown".to_string()),
            default_script: project
                .default_script
                .unwrap_or_else(|| "unknown".to_string()),
            is_app_valid: project.is_app_valid,
        }))
    }

    async fn update_app(
        &self,
        _request: Request<api::CreateAppPayload>,
    ) -> Result<Response<api::App>, Status> {
        Ok(Response::new(api::App::default()))
    }

    async fn remove_app(
        &self,
        request: Request<api::AppIdPayload>,
    ) -> Result<Response<api::AppIdPayload>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to acquire a database connection"))?;

        let project_id = request.into_inner().id;
        delete_project(conn, project_id)
            .map_err(|e| Status::not_found(format!("grpc error: {}", e)))?;
        Ok(Response::new(api::AppIdPayload { id: project_id }))
    }

    async fn read_all_apps(
        &self,
        _request: Request<api::EmptyParams>,
    ) -> Result<Response<api::AppList>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to acquire a database connection"))?;

        let projects = get_all_projects(conn)
            .map_err(|err| Status::not_found(format!("Failed to fetch projects: {}", err)))?;

        let apps = projects
            .into_iter()
            .map(|project| api::App {
                id: project.id,
                path: project.path,
                name: project.name,
                scripts: project
                    .scripts
                    .as_ref()
                    .map(|s| serde_json::from_str(s).unwrap_or_default())
                    .unwrap_or_default(),
                node_version: project
                    .node_version
                    .unwrap_or_else(|| "unknown".to_string()),
                default_script: project
                    .default_script
                    .unwrap_or_else(|| "unknown".to_string()),
                is_app_valid: project.is_app_valid,
            })
            .collect();

        Ok(Response::new(api::AppList { apps }))
    }

    async fn run_app(
        &self,
        _request: Request<api::RunAppRequest>,
    ) -> Result<Response<api::AppRunTime>, Status> {
        Ok(Response::new(api::AppRunTime::default()))
    }

    async fn stop_app(
        &self,
        _request: Request<api::StopAppRequest>,
    ) -> Result<Response<api::AppRunTime>, Status> {
        Ok(Response::new(api::AppRunTime::default()))
    }

    async fn sync_app_scripts(
        &self,
        _request: Request<api::AppIdPayload>,
    ) -> Result<Response<api::App>, Status> {
        Ok(Response::new(api::App::default()))
    }

    async fn update_default_run_script(
        &self,
        request: Request<api::UpdateDefaultRunScriptParams>,
    ) -> Result<Response<api::App>, Status> {
        let conn = &mut self
            .db_pool
            .get()
            .map_err(|_| Status::internal("Failed to acquire a database connection"))?;

        let params = request.into_inner();

        let mut project = get_project(conn, params.id)
            .map_err(|e| Status::not_found(format!("Project not found: {}", e)))?;

        let target_script = &params.script;

        let scripts: Vec<String> = project
            .scripts
            .as_deref()
            .map(serde_json::from_str)
            .transpose()
            .map_err(|_| Status::internal("Failed to parse project scripts"))?
            .unwrap_or_default();

        if !scripts.contains(target_script) {
            return Err(Status::invalid_argument(
                "Specified script does not exist in project scripts",
            ));
        }

        project.default_script = Some(target_script.clone());

        update_project(conn, &project)
            .map_err(|e| Status::internal(format!("Failed to update project: {}", e)))?;

        let response = api::App {
            id: project.id,
            path: project.path,
            name: project.name,
            scripts,
            node_version: project
                .node_version
                .unwrap_or_else(|| "unknown".to_string()),
            default_script: project
                .default_script
                .unwrap_or_else(|| "unknown".to_string()),
            is_app_valid: project.is_app_valid,
        };

        Ok(Response::new(response))
    }
}
