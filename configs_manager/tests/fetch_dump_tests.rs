mod fetch_dump;

#[test]
fn it_works() {
    let src = String::new();
    let dstn = String::new();
    let files:Vec<String> = Vec::new();
    fetch_dump::fetch_dump::fetch_config_files(src, dstn, files);
    let result = 2 + 2;
    assert_eq!(result, 4);
}
