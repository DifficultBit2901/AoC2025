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
    int ptr = 50;
    int points_at_zero_count = 0;

    while (!file.eof()) {
        int movement = common::parse_line(&file)!;
        if (movement == 0) {
            continue;
        }

        ptr += movement;
        while (ptr < 0) {
            ptr += 100;
        }
        while (ptr >= 100) {
            ptr -= 100;
        }
        if (ptr == 0) {
            points_at_zero_count++;
        }
    }
    return points_at_zero_count;
}
