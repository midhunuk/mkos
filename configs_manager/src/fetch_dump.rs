pub mod fetch_dump{
    use crate::config_files_info::config_files_info::ConfigFiles;
    use std::path::Path;

    pub fn fetch_config_files(config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> { 
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        Ok(())
    }

    pub fn dump_config_files  (config_files: &Vec<ConfigFiles>, repo_root_directory: &str) -> Result<(), Vec<String>> {
        check_if_repo_directory_exists_else_panic(repo_root_directory);
        Ok(())
    }

    fn check_if_repo_directory_exists_else_panic(repo_root_directory: &str){
        let does_repo_root_directory_exists: bool = Path::new(repo_root_directory).is_dir();
        if !does_repo_root_directory_exists{
            panic!("Repo root directory does not exists")
        }
    }
}

