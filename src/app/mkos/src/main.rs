use std::io;
mod operation;

fn main() {
    println!("Welcome to mkos !!!");
    loop
    {
        println!("Please select the operation");
        println!("1 : Dump configs");
        println!("2 : Fetch configs");

        let mut operation_input = String::new();
        io::stdin().read_line(&mut operation_input).unwrap();

        let operation = operation::get_operation(operation_input);

        if let operation::Operations::Fetch = operation{
            println!("Select the applications to fetch the config files");
        }
        else if let operation::Operations::Dump = operation{
            println!("Select the applications to dump the config files");
        }
        else {
            println!("Please select a valid operation");
        }

        println!("");
    }
}
