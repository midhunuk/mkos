use serde::{Deserialize, Serialize};
use serde_yaml::{self};
use std::path::PathBuf;
extern crate dirs;

#[derive(Debug, Serialize, Deserialize)]
pub struct ConfigFile{
    pub filename:String,
    pub config_file_location:String,
    pub config_file_repo_location:String
}

#[derive(Debug, Serialize, Deserialize)]
pub struct AppDetails{
    pub name:String,
    pub config_files:Vec<ConfigFile>
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Config{
    pub repo_root_path:String,
    pub app_details:Vec<AppDetails>
}

pub fn read_config() -> Config{
    let config_file_path = PathBuf::new().join(dirs::config_dir().unwrap()).join("config_manager/config.yml");
    println!("{}",config_file_path.display());
    let file = std::fs::File::open(config_file_path)
        .expect("Could not open the config file.");
    let config : Config = serde_yaml::from_reader(file)
        .expect("Could not read config values.");
    return config;
}

pub fn count_and_display_options(app_details: &Vec<AppDetails>) -> usize{
    let mut options_count: usize = 1;
    for app_detail in app_details{
        let app_name: &String = &app_detail.name;
        let options = format!("{options_count} : {app_name}");
        println!("{}",options);
        options_count = options_count +1;
    }
    return options_count;
} 