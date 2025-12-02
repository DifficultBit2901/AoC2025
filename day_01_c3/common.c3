module common;

import std::io;

faultdef NO_ARG_GIVEN, DIGIT_OUT_OF_RANGE;

fn File? open_input(String[] args) {
    if (args.len < 2) {
        return NO_ARG_GIVEN?;
    }

    return io::file::open(args[1], "r");
}

enum ErrCode : const int {
    FILE_NOT_FOUND = 1,
    NO_ARG,
    FILE_ERROR,

    UNKNOWN = -1,
}

fn ErrCode print_error(fault err, String[] args) {
    switch (err) {
        case NO_ARG_GIVEN: 
            io::printfn("Usage: %s <file>", args[0]);
            return NO_ARG;
        case io::FILE_NOT_FOUND:
            io::printfn("File %s not found", args[1]);
            return FILE_NOT_FOUND;
        default:
            io::printn(err);
            return UNKNOWN;
    }
}

fn int? parse_line(File* file) {
    char? dir = file.read_byte();
    if (catch dir) {
        return 0;
    }
    int ammount = 0;
    while (true) {
        char? byte = file.read_byte();
        if (catch byte) break;
        if (byte == '\n') break;
        if (byte < '0' || byte > '9') {
            return DIGIT_OUT_OF_RANGE?;
        }
        ammount *= 10;
        ammount += (int) (byte - '0');
    }
    if (dir == 'L') {
        ammount *= -1;
    }
    return ammount;
}
