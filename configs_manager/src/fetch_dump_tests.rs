#[cfg(test)]

mod tests {
    use crate::{fetch_dump::fetch_dump, config_files_info::config_files_info::ConfigFiles};
    
    #[ctor::ctor]
    fn init() {
        let test_directory = get_test_folder_path();
        std::fs::create_dir(test_directory).expect("test folder creation failed")
    }

    #[ctor::dtor]
    fn clean_up() {
        let test_directory = get_test_folder_path();
        std::fs::remove_dir_all(test_directory).expect("test folder deletion failed")
    }

    fn get_test_folder_path () -> std::path::PathBuf{
        let working_directory = std::env::current_dir().expect("Test init unknown path");
        working_directory.join("testfolder")
    }

    #[test]
    fn fetch_config_files_invalid_source_error_returned() {
        let test_directory = get_test_folder_path();
        let invalid_repo_root = test_directory.to_str().unwrap(); 
        let files:Vec<ConfigFiles> = Vec::new();

        let result = fetch_dump::fetch_config_files(&files, invalid_repo_root);

        let assert_result = match result {
            Ok(()) => true,
            Err(_) => false
        };
        assert!(assert_result);
    }

    #[test]
    #[should_panic(expected = "Repo root directory does not exists")]
    fn fetch_config_files_invalid_repo_root_panics() {
        let invalid_repo_root = "invalid/root/repo";
        let files:Vec<ConfigFiles> = Vec::new();

        fetch_dump::fetch_config_files(&files, invalid_repo_root);
    }

    #[test]
    #[should_panic(expected = "Repo root directory does not exists")]
    fn dump_config_files_invalid_repo_root_panics() {
        let invalid_repo_root = "invalid/root/repo";
        let files:Vec<ConfigFiles> = Vec::new();

        let result = fetch_dump::dump_config_files(&files, invalid_repo_root);
    }
}
