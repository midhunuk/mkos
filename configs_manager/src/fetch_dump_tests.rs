#[cfg(test)]

mod tests {
    use crate::{fetch_dump::fetch_dump, config_files_info::config_files_info::ConfigFiles};
    
    #[ctor::ctor]
    fn init() {
        let test_directory = get_test_folder_path();
        std::fs::create_dir(test_directory).expect("test folder creation failed");
        setup_test_folder_files();
    }

    #[ctor::dtor]
    fn clean_up() {
        let test_directory = get_test_folder_path();
        std::fs::remove_dir_all(test_directory).expect("test folder deletion failed");
    }

    fn get_test_folder_path() -> std::path::PathBuf{
        let working_directory = std::env::current_dir().expect("Test init unknown path");
        working_directory.join("testfolder")
    }

    fn get_test_folder_path_string() -> String{
        let test_directory = get_test_folder_path();
        test_directory.to_str().unwrap().to_string()
    }

    fn setup_test_folder_files() {
        //-> testfolder
        //  -> fetchfolder
        //      -> test.lua
        //  -> repofolder
        let test_directory = get_test_folder_path();
        let fetch_folder_directory = test_directory.join("fetchfolder");
        let repo_folder_directory = test_directory.join("repofolder");
        std::fs::create_dir(fetch_folder_directory).expect("fetch folder creation failed");
        std::fs::create_dir(repo_folder_directory).expect("repo folder creation failed");
        let file_a = test_directory.join("fetchfolder/test.lua");
        std::fs::File::create(file_a).expect("fileA creation failed");
    }

    fn get_test_configs_file(fetch_file: &str, repo_file: &str, filename: &str) -> ConfigFiles {
        let config_file = ConfigFiles{
            config_file_directory : String::from(format!("{}/{}", get_test_folder_path_string(), fetch_file)),
            repo_directory : String::from(format!("{}/{}", get_test_folder_path_string(), repo_file)),
            filename : String::from(filename)
        };
        config_file
    }

    fn assert_result_error(result: &Result<(),Vec<String>>) {
        let assert_result = match result {
            Ok(()) => false,
            Err(_) => true
        };
        assert!(assert_result);
    }

    fn assert_error_message(excepted_messages: &Vec<String>, actual_message: &Vec<String>){
        assert!(excepted_messages.len() == actual_message.len());
        println!("{}", actual_message.len());
        for n in 0..actual_message.len(){
            assert_eq!(excepted_messages[n], actual_message[n])
        }
    }

    #[test]
    #[should_panic(expected = "Repo root directory does not exists")]
    fn fetch_config_files_invalid_repo_root_panics() {
        let invalid_repo_root = "invalid/root/repo";
        let files:Vec<ConfigFiles> = Vec::new();

        let result = fetch_dump::fetch_config_files(&files, invalid_repo_root);
        
        //dead code for compiler
        assert_result_error(&result)
    }

    #[test]
    #[should_panic(expected = "Repo root directory does not exists")]
    fn dump_config_files_invalid_repo_root_panics() {
        let invalid_repo_root = "invalid/root/repo";
        let files:Vec<ConfigFiles> = Vec::new();

        let result = fetch_dump::dump_config_files(&files, invalid_repo_root);

        //dead code for compiler
        assert_result_error(&result)
    }

    #[test]
    fn fetch_config_files_invalid_config_files_path() {
        let test_directory = get_test_folder_path();
        let repo_folder = test_directory.join("repofolder");
        let mut files:Vec<ConfigFiles> = Vec::new();
        files.push(get_test_configs_file("fetchfolder", "repofolder", "test.lua"));
        files.push(get_test_configs_file("fetchfolder/test", "repofolder", "test.lua"));
        files.push(get_test_configs_file("fetchfolder", "repofolder", "test.rs"));
        let mut excepted_messages:Vec<String> = Vec::new();
        excepted_messages.push(format!("{}/fetchfolder/test/test.lua not found", get_test_folder_path_string()));
        excepted_messages.push(format!("{}/fetchfolder/test.rs not found", get_test_folder_path_string()));

        let result = fetch_dump::fetch_config_files(&files, repo_folder.to_str().unwrap());
        
        assert_result_error(&result);
        let actual_message = result.err().unwrap(); 
        assert_error_message(&excepted_messages, &actual_message);
    }
}
