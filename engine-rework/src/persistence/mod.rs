use std::path::PathBuf;

pub mod schema;
pub mod storage;

pub fn get_temp_path() -> PathBuf {
    std::env::current_exe().expect("Failed to get executable path")
}
