use std::collections::HashMap;

use crate::runners::utils::deserialize_lts;
use reqwest::{Client, Response, Url};
use serde::Deserialize;

#[derive(Deserialize, Debug)]
pub struct Node {
    pub version: String,
    #[serde(skip_deserializing)]
    pub date: String,
    files: Vec<String>,
    // #[serde(deserialize_with = "deserialize_empty_as_none")]
    #[serde(skip_deserializing)]
    npm: Option<String>,
    #[serde(skip_deserializing)]
    v8: String,
    #[serde(skip_deserializing)]
    uv: String,
    #[serde(skip_deserializing)]
    zlib: String,
    #[serde(skip_deserializing)]
    openssl: String,
    #[serde(skip_deserializing)]
    modules: String,
    #[serde(deserialize_with = "deserialize_lts")]
    pub lts: bool,
    #[serde(skip_deserializing)]
    security: bool,
}

pub struct NodeJsOrgClient {
    base_url: Url,
}

impl NodeJsOrgClient {
    pub fn new() -> Self {
        Self {
            base_url: Url::parse("https://nodejs.org/dist").unwrap(),
        }
    }

    pub async fn fetch_node_list(
        &self,
        lts_only: bool,
        latest_only: bool,
    ) -> Result<Vec<Node>, Box<dyn std::error::Error>> {
        let response = self.get("/index.json").await?;
        let mut nodes: Vec<Node> = response.json().await?;

        if lts_only {
            nodes.retain(|node| node.lts);
        }
        if latest_only {
            nodes = NodeJsOrgClient::filter_latest_versions(nodes);
        }

        Ok(nodes)
    }

    async fn get(&self, path: &str) -> Result<Response, Box<dyn std::error::Error>> {
        let url = format!("{}{}", self.base_url, path);
        let response = Client::new()
            .get(url)
            .header("User-Agent", concat!("ssme ", env!("CARGO_PKG_VERSION")))
            .send()
            .await?;

        Ok(response)
    }

    fn filter_latest_versions(versions: Vec<Node>) -> Vec<Node> {
        let mut latest_versions: HashMap<String, Node> = HashMap::new();

        for node in versions {
            if let Some(major) = node
                .version
                .strip_prefix('v')
                .and_then(|v| v.split('.').next())
            {
                let major = major.to_string();

                if let Some(existing) = latest_versions.get(&major) {
                    if node.version > existing.version {
                        latest_versions.insert(major, node);
                    }
                } else {
                    latest_versions.insert(major, node);
                }
            }
        }

        let mut result: Vec<Node> = latest_versions.into_values().collect();

        // Сортируем по major, minor, patch (по убыванию)
        result.sort_by(|a, b| {
            let parse_version = |v: &str| {
                v.strip_prefix('v')
                    .unwrap_or(v)
                    .split('.')
                    .map(|s| s.parse::<u32>().unwrap_or(0))
                    .collect::<Vec<u32>>()
            };

            let va = parse_version(&a.version);
            let vb = parse_version(&b.version);

            va.cmp(&vb).reverse()
        });

        result
    }
}
