#[derive(PartialEq)]
pub enum Operations {
    Dump,
    Fetch,
    Undefined
}

pub fn get_operation(input:String) -> Operations{

    let mut operation = Operations::Undefined;
    let input = input.trim().to_lowercase();
    if input == "fetch" || input =="1"{
        operation = Operations::Fetch;
    }
    else if input == "dump" || input == "2"{
        operation = Operations::Dump;
    }

    operation
}