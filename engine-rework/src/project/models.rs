use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

use crate::schema::projects;

#[derive(Queryable, PartialEq, Serialize, Deserialize, AsChangeset)]
pub struct Project {
    #[serde(skip_deserializing)]
    pub id: i32,
    pub name: String,
    pub path: String,
    pub scripts: Option<String>,
    pub node_version: Option<String>,
    pub default_script: Option<String>,
    pub is_app_valid: bool,
    pub created_at: NaiveDateTime,
}

#[derive(Insertable, Deserialize)]
#[diesel(table_name=projects)]
pub struct NewProject<'a> {
    pub path: &'a str,
    pub name: &'a str,
    pub scripts: String,
    pub node_version: &'a str,
    pub default_script: &'a str,
    pub is_app_valid: bool,
}
