pub mod fetch_dump{
    use crate::config_files_info::{config_files_info::ConfigFiles, self};
    use std::path::Path;

    pub fn fetch_config_files(config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> { 
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        let error_messages = check_config_files_path(config_files);
        if !error_messages.is_empty() {
            return Err(error_messages);
        }
        Ok(())
    }

    pub fn dump_config_files  (config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> {
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        Ok(())
    }

    fn check_if_repo_directory_exists_else_panic(repo_root_directory: &str){
        let does_repo_root_directory_exists: bool = Path::new(repo_root_directory).is_dir();
        if !does_repo_root_directory_exists{
            panic!("Repo root directory does not exists");
        }
    }

    fn check_config_files_path(config_files: &Vec<ConfigFiles>) -> Vec<String>{
        let mut error_messages: Vec<String> = Vec::new();
        for config_file in config_files {
            let config_file_directory = Path::new(&config_file.config_file_directory);
            let config_files_path = config_file_directory.join(&config_file.filename);
            let does_file_exists = config_files_path.exists();
            if !does_file_exists {
                let message = format!("{} not found", config_files_path.to_str().unwrap());
                error_messages.push(message);
            }
        }; 
        error_messages
    }
}

