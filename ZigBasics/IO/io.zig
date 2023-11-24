const std = @import("std");
const print = std.debug.print;
const input = std.io.getStdIn().reader();

pub fn main() !void {
    const Max_Size = 256;
    var a: [Max_Size]u8 = undefined;

    // Without using Allocator
    print("Without Allocator: ", .{});
    const Name = try input.readUntilDelimiter(&a, '\n');
    print("The user entered: {s}\n", .{Name});

    // Using Allocator
    var a_buf = std.heap.FixedBufferAllocator.init(&a);
    const writer = a_buf.allocator();
    print("With Allocator: ", .{});
    const AllocatorName = (try input.readUntilDelimiterOrEofAlloc(writer, '\n', Max_Size)).?;
    print("The user entered : {s}\n", .{AllocatorName});
}
