import std::io, common;

fn int main(String[] args) {
    File? file = common::open_input(args);
    if (catch err = file) {
        return (int) common::print_error(err, args);
    }
    defer (void)file.close();

    int? result = handle_file(file);
    if (catch err = result) {
        io::printn(err);
        return (int) ErrCode.UNKNOWN;
    } 

    io::printfn("Result = %d", result);

    return 0;
}

fn int? handle_file(File file) {
    int128 ptr = 50;
    int count = 0;

    int line = 0;
    while (!file.eof()) {
        line++;
        int movement = common::parse_line(&file)!;
        if (movement == 0) {
            continue;
        }
        if (movement > 0) {
            while(movement > 0) {
                ptr++;
                if (ptr == 100) {
                    ptr = 0;
                }
                if (ptr == 0) {
                    count++;
                    io::printfn("Passed by line %d", line);
                }
                movement--;
            }
        } else {
            while (movement < 0) {
                ptr--;
                if (ptr == -1) {
                    ptr = 99;
                }
                if (ptr == 0) {
                    count++;
                    io::printfn("Passed by line %d", line);
                }
                movement++;
            }
        }
    }
    return count;
}
