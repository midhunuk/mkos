#[cfg(test)]

mod tests {

    use crate::{fetch_dump::fetch_dump, config_files_info::config_files_info::ConfigFiles};
    
    #[ctor::ctor]
    fn init() {
        let mut test_directory = get_test_folder_path();
        if test_directory.is_dir(){
            std::fs::remove_dir_all(test_directory).expect("test folder deletion in init failed");
            test_directory = get_test_folder_path();
        }
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
        //      -> app
        //          ->test
        //              ->test.lua
        //          ->test.lua
        //          ->test.rs
        //  -> repofolder
        let test_directory = get_test_folder_path();
        let fetch_folder_directory = test_directory.join("fetchfolder");
        let repo_folder_directory = test_directory.join("repofolder");
        std::fs::create_dir(fetch_folder_directory).expect("fetch folder creation failed");
        std::fs::create_dir(repo_folder_directory).expect("repo folder creation failed");
        create_file("fetchfolder","test.lua");
        create_file("fetchfolder/app","test.lua");
        create_file("fetchfolder/app/test","test.lua");
        create_file("fetchfolder/app","test.rs");

        create_file("repofolder","test.lua");
        create_file("repofolder/app1","test.lua");
        create_file("repofolder/app1/folder","test.lua");
        create_file("repofolder/app1","test.rs");
    }

    fn create_file(directory_path: &str, filename: &str){
        let test_directory = get_test_folder_path();
        let file_directory = test_directory.join(directory_path);
        if !file_directory.is_dir() {
            std::fs::create_dir(file_directory).expect("directory creation failed during file creation")
        }
        let filepath = test_directory.join(directory_path).join(filename);
        std::fs::File::create(filepath).expect("file creation failed");
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

    fn assert_result_ok(result: &Result<(),Vec<String>>) {
        let assert_result = match result {
            Ok(()) => true,
            Err(_) => false
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

    fn assert_file_exists(filepath: &str) {
        let test_directory = get_test_folder_path();
        let file_path = test_directory.join(filepath);
        file_path.try_exists().expect("File does not exists"); 
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

    #[test]
    fn fetch_config_files_valid_config_files_path_no_panic() {
        let test_directory = get_test_folder_path();
        let repo_folder = test_directory.join("repofolder");
        let mut files:Vec<ConfigFiles> = Vec::new();
        files.push(get_test_configs_file("fetchfolder/app", "repofolder/app/", "test.lua"));
        files.push(get_test_configs_file("fetchfolder/app/test", "repofolder/app/folder", "test.lua"));
        files.push(get_test_configs_file("fetchfolder/app", "repofolder/app", "test.rs"));

        let result = fetch_dump::fetch_config_files(&files, repo_folder.to_str().unwrap());
        
        assert_result_ok(&result);
        assert_file_exists("repofolder/app/test.lua");
        assert_file_exists("repofolder/app/folder/test.lua");
        assert_file_exists("repofolder/app/test.rs");
    }

    #[test]
    fn dump_config_files_invalid_config_files_path() {
        let test_directory = get_test_folder_path();
        let repo_folder = test_directory.join("repofolder");
        let mut files:Vec<ConfigFiles> = Vec::new();
        files.push(get_test_configs_file("fetchfolder", "repofolder", "test.lua"));
        files.push(get_test_configs_file("fetchfolder", "repofolder/test", "test.lua"));
        files.push(get_test_configs_file("fetchfolder", "repofolder", "test.rs"));
        let mut excepted_messages:Vec<String> = Vec::new();
        excepted_messages.push(format!("{}/repofolder/test/test.lua not found", get_test_folder_path_string()));
        excepted_messages.push(format!("{}/repofolder/test.rs not found", get_test_folder_path_string()));

        let result = fetch_dump::dump_config_files(&files, repo_folder.to_str().unwrap());
        
        assert_result_error(&result);
        let actual_message = result.err().unwrap(); 
        assert_error_message(&excepted_messages, &actual_message);
    }

    #[test]
    fn dump_config_files_valid_config_files_path_no_panic() {
        let test_directory = get_test_folder_path();
        let repo_folder = test_directory.join("repofolder");
        let mut files:Vec<ConfigFiles> = Vec::new();
        files.push(get_test_configs_file("fetchfolder/app1", "repofolder/app1/", "test.lua"));
        files.push(get_test_configs_file("fetchfolder/app1/test", "repofolder/app1/folder", "test.lua"));
        files.push(get_test_configs_file("fetchfolder/app1", "repofolder/app1", "test.rs"));

        let result = fetch_dump::dump_config_files(&files, repo_folder.to_str().unwrap());
        
        assert_result_ok(&result);
        assert_file_exists("fetchfolder/app1/test.lua");
        assert_file_exists("fetchfolder/app1/folder/test.lua");
        assert_file_exists("fetchfolder/app1/test.rs");
    }
}
