const std = @import("std");
const File = std.fs.File;

pub fn open_input() !File {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const arg_allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const args = std.process.argsAlloc(arg_allocator) catch |err| {
        std.debug.print("Failed to allocate arguments: {}\n", .{err});
        return err;
    };
    defer std.process.argsFree(arg_allocator, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} <input-file>\n", .{args[0]});
        return error.NoArgGiven;
    }

    const file = std.fs.cwd().openFile(args[1], .{}) catch |err| {
        std.debug.print("Failed to open {s}: {}\n", .{ args[1], err });
        return err;
    };
    return file;
}

pub fn find_largest(line: []u8, start: usize, end: usize) usize {
    var largest_index = start;
    for ((start + 1)..end) |i| {
        if (line[i] > line[largest_index]) {
            largest_index = i;
        }
    }
    return largest_index;
}
