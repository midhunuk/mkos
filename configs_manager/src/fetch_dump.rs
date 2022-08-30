pub mod fetch_dump{
    use crate::config_files_info::config_files_info::ConfigFiles;
    use core::panic;
    use std::path::{Path, PathBuf};

    pub fn fetch_config_files(config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> { 
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        let error_messages = validate_config_files_path(config_files);
        if !error_messages.is_empty() {
            return Err(error_messages);
        }
        for config_file in config_files {
            create_repo_directory_if_not_existing(repo_root_directory, &config_file.repo_directory);
            let config_file_path = create_config_file_path(config_file);
            let repo_file_path = create_repo_file_path(config_file, repo_root_directory);
            let copy_result = std::fs::copy(config_file_path, repo_file_path);
            if copy_result.is_err(){
                panic!("copying failed");
            } 
        }
        Ok(())
    }

    pub fn dump_config_files  (config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> {
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        let error_messages = validate_repo_files_path(repo_root_directory, config_files);
        if !error_messages.is_empty() {
            return Err(error_messages);
        }
        for config_file in config_files {
            create_config_directory_if_not_existing(&config_file.config_file_directory);
            let config_file_path = create_config_file_path(config_file);
            let repo_file_path = create_repo_file_path(config_file, repo_root_directory);
            let copy_result = std::fs::copy(repo_file_path, config_file_path);
            if copy_result.is_err(){
                panic!("copying failed");
            } 
        }
        Ok(())
    }

    fn check_if_repo_directory_exists_else_panic(repo_root_directory: &str){
        let does_repo_root_directory_exists: bool = Path::new(repo_root_directory).is_dir();
        if !does_repo_root_directory_exists{
            panic!("Repo root directory does not exists");
        }
    }

    fn validate_config_files_path(config_files: &Vec<ConfigFiles>) -> Vec<String>{
        let mut error_messages: Vec<String> = Vec::new();
        for config_file in config_files {
            let config_files_path = create_config_file_path(config_file);
            let does_file_exists = config_files_path.exists();
            if !does_file_exists {
                let message = format!("{} not found", config_files_path.to_str().unwrap());
                error_messages.push(message);
            }
        }; 
        error_messages
    }

    fn create_config_file_path(config_file: &ConfigFiles) -> PathBuf {
        let config_file_directory = Path::new(&config_file.config_file_directory);
        config_file_directory.join(&config_file.filename)
    }

    fn create_repo_file_path(config_files: &ConfigFiles, repo_root_directory: &str) -> PathBuf {
        let repo_root_directoty_path = Path::new(repo_root_directory); 
        repo_root_directoty_path.join(&config_files.repo_directory).join(&config_files.filename)
    }

    fn create_repo_directory_if_not_existing(repo_root_directory: &str, repo_directory: &str) {
        let repo_directory_path = Path::new(repo_root_directory).join(repo_directory); 
        if !repo_directory_path.is_dir(){
            std::fs::create_dir(repo_directory_path).expect("directory creation")
        }
    }

    fn validate_repo_files_path(repo_root_directory: &str, config_files: &Vec<ConfigFiles>) -> Vec<String>{
        let mut error_messages: Vec<String> = Vec::new();
        for config_file in config_files {
            let repo_files_path = create_repo_file_path(config_file, repo_root_directory);
            let does_file_exists = repo_files_path.exists();
            if !does_file_exists {
                let message = format!("{} not found", repo_files_path.to_str().unwrap());
                error_messages.push(message);
            }
        }; 
        error_messages
    }

    fn create_config_directory_if_not_existing(config_directory: &str) {
        let config_directory_path = Path::new(config_directory);
        if !config_directory_path.is_dir(){
            std::fs::create_dir(config_directory_path).expect("directory creation")
        }
    }
}
