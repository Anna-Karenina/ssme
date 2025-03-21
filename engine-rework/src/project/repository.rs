use diesel::associations::HasTable;
use diesel::prelude::*;

use crate::project::models::{NewProject, Project};
use crate::schema::projects::dsl::*;

pub fn create_project(
    conn: &mut SqliteConnection,
    new_project: NewProject,
) -> Result<Project, diesel::result::Error> {
    diesel::insert_into(projects)
        .values(&new_project)
        .execute(conn)?;

    let project = projects.order(id.desc()).first(conn)?;

    Ok(project)
}

pub fn get_project(
    conn: &mut SqliteConnection,
    project_id: i32,
) -> Result<Project, diesel::result::Error> {
    projects.find(project_id).get_result(conn)
}

pub fn get_all_projects(
    conn: &mut SqliteConnection,
) -> Result<Vec<Project>, diesel::result::Error> {
    projects.load::<Project>(conn)
}

pub fn delete_project(
    conn: &mut SqliteConnection,
    project_id: i32,
) -> Result<usize, diesel::result::Error> {
    diesel::delete(projects.filter(id.eq(project_id))).execute(conn)
}

pub fn update_project(
    conn: &mut SqliteConnection,
    project: &Project,
) -> Result<(), diesel::result::Error> {
    diesel::update(projects.filter(id.eq(project.id)))
        .set(project)
        .execute(conn)?;

    Ok(())
}
