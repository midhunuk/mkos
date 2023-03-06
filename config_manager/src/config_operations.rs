use std::fmt;
use std::path::Path;
use std::fs;
use std::path::PathBuf;
use std::fs::File;

use crate::app_details::{AppDetails};
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

pub fn perform_config_operation(selected_config_operation : ConfigOperations, app_details: Vec<&AppDetails>, repo_root_path: &String){

    for app_detail in app_details{
        for config_file in &app_detail.config_files{
            let repo_file_path = get_file_path(config_file, repo_root_path);
            let app_file_path = get_file_path(config_file, &app_detail.config_location);
            match selected_config_operation {
                ConfigOperations::CopyFromSource => copy_file(repo_file_path, app_file_path),
                ConfigOperations::CopyToSource => copy_file(app_file_path, repo_file_path),
            }
        }
    }
}

fn get_file_path(file_path: &String, root_path: &String) -> PathBuf {
    return Path::new(root_path).join(file_path);
}

fn copy_file(source_file_path: PathBuf, target_file_path: PathBuf) {
    if !source_file_path.exists(){
        panic!("Source file does not exists");
    }

    if !target_file_path.exists(){
        File::create(&target_file_path).expect("failed on creating file");
    }
    fs::copy(source_file_path, target_file_path).expect("Failed on copying files");
}
