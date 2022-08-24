mod fetch_dump;

fn main() {
    println!("Hello, world!");
    let src = String::new();
    let dstn = String::new();
    let files:Vec<String> = Vec::new();
    fetch_dump::fetch_dump::fetch_config_files(src, dstn, files);
}
