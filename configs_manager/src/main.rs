mod config_files_info;
mod fetch_dump;
mod fetch_dump_tests;  

use crate::config_files_info::config_files_info::ConfigFiles;

fn main() {
    println!("Hello, world!");
    let repo_root_directory = String::new();
    let files:Vec<ConfigFiles> = Vec::new();

    fetch_dump::fetch_dump::fetch_config_files(&files, &repo_root_directory);
}
