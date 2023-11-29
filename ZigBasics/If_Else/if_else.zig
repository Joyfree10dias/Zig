const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

pub fn main() void {
    const a: u32 = 4;
    const b: u32 = 5;

    // Method 1
    const result = if (a < b) "a is less than b" else "a is greater than b";
    print("Result : {s}\n", .{result});

    // Method 2
    const temp: ?u8 = 3;
    if (temp) |value| {
        print("Not null\n", .{});
        print("value : {d} and temp : {any}\n", .{value, @TypeOf(temp)});
    } else {
        print("value is {any}\n", .{temp});
    }
    
    // Method 3
    const c: u8 = 3;
    if (c == 2) {
        print("value is 2\n", .{});
    } else if (c == 3) {
        print("value is greater than 2\n", .{});
    } else {
        print("value is greater than 3\n", .{});
    }
}
