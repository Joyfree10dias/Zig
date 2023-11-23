const std = @import("std");
pub fn main() !void {
    const StdOut = std.io.getStdOut().writer();
    try StdOut.print("Hello {s}!!\n", .{"World"});
    try UsingdebugPrint();
}

// Using Debug Print 
const print = @import("std").debug.print;
pub fn UsingdebugPrint() !void {
    print("Using Debug Print : {s}\n", .{"Hello, World"});
}
