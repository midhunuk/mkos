use std::fmt;
use std::fs;
use std::path::PathBuf;
use std::fs::File;
extern crate dirs;

use crate::app_details::{AppDetails, ConfigFile};
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

pub fn perform_config_operation(selected_config_operation: ConfigOperations, app_details: Vec<&AppDetails>, repo_root_path: &String){
    match selected_config_operation {
        ConfigOperations::CopyFromSource => copy_files_from_repo(app_details, repo_root_path),
        ConfigOperations::CopyToSource => copy_files_to_repo(app_details, repo_root_path)
    }
}

fn copy_files_from_repo(app_details: Vec<&AppDetails>, repo_root_path: &String) {
    for app_detail in app_details{
        for config_file in &app_detail.config_files{
            let source_file_path = get_repo_file_path(config_file, repo_root_path);
            let target_file_path = get_config_file_path(config_file);
            let target_file_directory_path = PathBuf::new().join(&config_file.config_file_location);
            copy_file(source_file_path, target_file_path, target_file_directory_path);
            println!("Copied {} to {}", config_file.filename, &config_file.config_file_location)          
        }
    }
}

fn copy_files_to_repo(app_details: Vec<&AppDetails>, repo_root_path: &String) {
    for app_detail in app_details{
        for config_file in &app_detail.config_files{
            let target_file_path = get_repo_file_path(config_file, repo_root_path);
            let source_file_path = get_config_file_path(config_file);
            let target_file_directory_path = PathBuf::new().join(repo_root_path).join(&config_file.config_file_location);
            copy_file(source_file_path, target_file_path, target_file_directory_path);
            println!("Copied {} to {}/{}", config_file.filename, repo_root_path, &config_file.config_file_repo_location)          
        }
    }
}

fn get_repo_file_path(config_file: &ConfigFile, repo_root_path: &String) -> PathBuf{
    return PathBuf::new().join(repo_root_path).join(&config_file.config_file_repo_location).join(&config_file.filename);
}

fn get_config_file_path(config_file: &ConfigFile) -> PathBuf{
    let home_dir = dirs::home_dir().expect("Failed on reading home dir");
    let home_dir_string = home_dir.to_str().expect("Failed to convert home dir to string");
    return PathBuf::new().join(&config_file.config_file_location.replace("~",home_dir_string)).join(&config_file.filename);
}

fn copy_file(source_file_path: PathBuf, target_file_path: PathBuf, target_file_directory_path: PathBuf) {
    if !source_file_path.exists(){
        panic!("Source file does not exists");
    }

    if !target_file_path.try_exists().expect("Failed on checking if the target exists"){
        if !target_file_directory_path.try_exists().expect("Failed on checking if the target directory exists"){
            fs::create_dir_all(target_file_directory_path).expect("Failed on creating target directory")
        }
        File::create(&target_file_path).expect("failed on creating file");
    }
    fs::copy(source_file_path, target_file_path).expect("Failed on copying files");
}