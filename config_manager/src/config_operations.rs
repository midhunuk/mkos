use std::fmt;
use std::path::Path;

use crate::app_details::AppDetails;
pub enum ConfigOperations {
    CopyFromSource = 1,
    CopyToSource
}

impl ConfigOperations {
    pub fn from_usize(value: usize) -> ConfigOperations {
        match value {
            1 => ConfigOperations::CopyFromSource,
            2 => ConfigOperations::CopyToSource,
            _ => panic!("Unknown value for config operations: {}", value),
        }
    }
}

impl fmt::Display for ConfigOperations {
     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            ConfigOperations::CopyFromSource => write!(f, "Copying config files from source"),
            ConfigOperations::CopyToSource => write!(f, "Copying config files to source"),
        }
    }
}

pub fn perform_config_operation(selected_config_operation : ConfigOperations, app_details: Vec<&AppDetails>, repo_rooth_path: &String){
    let (repo_file_paths, app_file_paths)  = get_file_paths(app_details, repo_rooth_path);
    match selected_config_operation {
        ConfigOperations::CopyFromSource => copy_files(repo_file_paths, app_file_paths),
        ConfigOperations::CopyToSource => copy_files(app_file_paths, repo_file_paths),
    }
}

fn get_file_paths(app_details: Vec<&AppDetails>, source_path: &String) -> (Vec<String>, Vec<String>) {
    todo!()
}

fn copy_files(source_file_paths: Vec<String>, target_file_paths: Vec<String>) {
    todo!()
}
