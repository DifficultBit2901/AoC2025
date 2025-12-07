const std = @import("std");
const common = @import("common.zig");

pub fn main() void {
    var file = common.open_input() catch {
        std.process.exit(1);
    };
    defer file.close();

    var file_buffer: [1024]u8 = undefined;
    var file_reader = file.reader(&file_buffer);

    const input = &file_reader.interface;
    var result: u128 = 0;
    while (true) {
        const line = input.takeDelimiterExclusive('\n') catch |err| {
            if (err != error.EndOfStream)
                std.debug.print("Error reading file: {}", .{err});
            break;
        };
        _ = input.takeByte() catch |err| {
            if (err != error.EndOfStream)
                std.debug.print("Error reading file: {}", .{err});
            break;
        };
        if (line.len == 0) {
            break;
        }

        const largest_idx = common.find_largest(line, 0, line.len - 1);
        const second_largest_idx = common.find_largest(line, largest_idx + 1, line.len);
        const number = (line[largest_idx] - '0') * 10 + line[second_largest_idx] - '0';
        result += @as(u128, number);
    }

    std.debug.print("Result: {}\n", .{result});
}
