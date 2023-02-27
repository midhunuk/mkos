pub mod app_details;
use std::io;

fn main() {
    println!("debug:start");
    let config: app_details::Config = app_details::read_config();
    let app_count: usize = app_details::count_and_display_options(&config.app_details);

    let mut user_input = String::new();
    let stdin = io::stdin();
    stdin.read_line(&mut user_input).expect("Error while reading user input");
    let selected_option :usize = user_input.trim().parse().expect("Entered value is not a number");
    if selected_option <=0 || selected_option > app_count{
        println!("Select a valid option");
        return;
    }
    let selected_app = &config.app_details[selected_option-1];
    let app_name = &selected_app.name;
    println!("{app_name}");
    println!("debug:end");
}
