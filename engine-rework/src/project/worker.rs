use std::collections::HashMap;
use std::fs;
use std::io;

use regex::Regex;
use serde::Deserialize;

pub struct ProjectWorker {
    pub path: Option<String>,
}

impl ProjectWorker {
    pub fn new(path: &str) -> Self {
        Self {
            path: Some(path.to_string()),
        }
    }

    pub fn read_project_directory(&self) -> Result<String, io::Error> {
        let package_json_path = format!("{}/package.json", self.path.as_ref().unwrap().to_string());
        let is_package_json_exist = match fs::exists(&package_json_path) {
            Ok(true) => true,
            Ok(false) => false,
            Err(_) => false,
        };

        if is_package_json_exist {
            Ok(package_json_path)
        } else {
            Err(io::Error::new(
                io::ErrorKind::NotFound,
                "package.json not found",
            ))
        }
    }
}

#[derive(Debug, Deserialize)]
pub struct Engines {
    pub node: Option<String>,
    pub npm: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct PackageJsonParser {
    pub path: Option<String>,
    pub scripts: Option<HashMap<String, String>>,
    #[serde(rename = "version")]
    pub project_version: Option<String>,
    #[serde(rename = "engines")]
    pub engine_version: Option<Engines>,
}

impl PackageJsonParser {
    pub fn parse(path: String) -> std::io::Result<PackageJsonParser> {
        let file_content = fs::read_to_string(&path)?;
        let mut project: PackageJsonParser = serde_json::from_str(&file_content)?;
        project.path = Some(path);
        Ok(project)
    }

    pub fn populate_node_version(mut self, project_dir: &str) -> Self {
        let node_version = self
            .engine_version
            .as_ref()
            .and_then(|engines| engines.node.clone())
            .unwrap_or_else(|| self.parse_npmrc(project_dir));

        self.engine_version = Some(Engines {
            node: Some(node_version),

            npm: self.engine_version.and_then(|engines| engines.npm),
        });

        self
    }

    pub fn parse_npmrc(&self, project_dir: &str) -> String {
        let default_version = "v20.0.0".to_string();

        let npmrc_path = format!("{}/.npmrc", project_dir);
        let node_version_path = format!("{}/.node_version", project_dir);

        let version = fs::read_to_string(&node_version_path)
            .or_else(|_| fs::read_to_string(&npmrc_path))
            .map(|content| content.trim().to_string())
            .unwrap_or_else(|_| default_version.clone());

        let sanitized_version: String = version
            .chars()
            .filter(|c| c.is_ascii_digit() || *c == '.')
            .collect();

        let version_regex = Regex::new(r"^\d+(\.\d+){2}$").unwrap();
        if version_regex.is_match(&sanitized_version) {
            sanitized_version
        } else {
            default_version
        }
    }
}
