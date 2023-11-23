const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

// Returns the square of the number
pub fn Square(number: i16) i16 {
    return number * number;
}

// Testing Square
test Square {
    try expect(Square(3) == 9);
}

test "expect Square squares 3 ==> 9" {
    try expect(Square(3) == 9);
}

// Skipping Test 
test "Skipping test"{
    return error.SkipZigTest;
}

// Testing failure
test "Failure check" {
    try expect(false);
}

// Reporting Memory Leaks
test "Report leaks"{
    var list = std.ArrayList(u21).init(std.testing.allocator);
    // missing `defer list.deinit();`
    try list.append('☔');

    try std.testing.expect(list.items.len == 1);
}