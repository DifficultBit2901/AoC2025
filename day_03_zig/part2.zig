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

        var number: u128 = 0;
        const max_digits = 12;
        var prev_largest_index: usize = 0;
        for (0..max_digits) |i| {
            if (i == 0) {
                prev_largest_index = common.find_largest(line, 0, line.len - (max_digits - 1 - i));
            } else {
                prev_largest_index = common.find_largest(line, prev_largest_index + 1, line.len - (max_digits - 1 - i));
            }
            number *= 10;
            number += @as(u128, line[prev_largest_index] - '0');
        }

        result += number;
    }

    std.debug.print("Result: {}\n", .{result});
}
