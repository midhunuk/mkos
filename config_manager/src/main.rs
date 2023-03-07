pub mod app_details;
pub mod config_operations;
use std::io;

use crate::app_details::AppDetails;
use crate::config_operations::ConfigOperations;

fn main() {
    //Initialize
    let config: app_details::Config = app_details::read_config();
    let app_count: usize = app_details::count_and_display_options(&config.app_details);

    //Select app
    let selected_option: usize = get_user_input();
    if selected_option <=0 || selected_option > app_count{
        println!("Select a valid option");
        return;
    }
    let selected_app:&AppDetails = &config.app_details[selected_option-1];

    // Select operations
    println!("Select");
    println!("1: For copying from repo");
    println!("2: For copying to repo");
    let selected_option: usize = get_user_input();
    let selected_config_operation:ConfigOperations = ConfigOperations::from_usize(selected_option);

    // Perfomr operations
    let app_details: Vec<&AppDetails> = vec![selected_app];
    config_operations::perform_config_operation(selected_config_operation, app_details, &config.repo_root_path);

}

fn get_user_input() -> usize{
    let mut user_input = String::new();
    let stdin = io::stdin();
    stdin.read_line(&mut user_input)
        .expect("Error while reading user input");
    let selected_option :usize = user_input.trim()
        .parse()
        .expect("Entered value is not a number");
    return selected_option;
}