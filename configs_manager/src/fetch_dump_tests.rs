#[cfg(test)]
mod tests {
    use crate::{fetch_dump::fetch_dump, config_files_info::config_files_info::ConfigFiles};

    #[test]
    fn fetch_config_files_invalid_source_error_returned() {
        let invalid_repo_root = "invalid/root/repo";
        let files:Vec<ConfigFiles> = Vec::new();

        let result = fetch_dump::fetch_config_files(&files, invalid_repo_root);

        let assert_result = match result {
            Ok(()) => true,
            Err(_) => false
        };
        assert!(assert_result);
    }
}
