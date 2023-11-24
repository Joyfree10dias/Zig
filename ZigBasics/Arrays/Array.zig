const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

const MyIntArray = [_]u8{ 1, 2, 3, 4, 5, 6 };
const MyCharArray = [_]u8{ '1', '2', '3', '4', '5', '6', '7', '8', '9' };

// For testing
const TestArray = [_:0]u8{ 1, 2, 3, 4 };

// 2D arrays
const Matrix = [3][3]u16{
    [_]u16 {1, 2, 3},
    [_]u16 {4, 5, 6},
    [_]u16 {7, 8, 9}
};

pub fn main() !void {
    // Printing integer array
    print("My Integer Array : {any} and length : {}\n", .{ MyIntArray, MyIntArray.len });

    // Printing character array
    print("My Character Array : {s} and length : {}\n", .{ MyCharArray, MyCharArray.len });

    // Printing TestArray
    print("Test Array : {any} and length : {}\n", .{ TestArray, TestArray.len });

    // Printing 2D array 
    print("Matrix : {any} and length : {}\n", .{Matrix, Matrix.len});

    // Display Matrix
    try Display();
}

test "Null terminated array" {
    try expect(@TypeOf(TestArray) == [4:0]u8);
    try expect(TestArray[4] == 0);
    try expect(TestArray.len == 4);
}

// Here we iterate with for loops 
pub fn Display() !void {
    for (Matrix, 0..) |row, i| {
        for (row, 0..) |cell, j| {
            print("i : {}, j : {}, cell : {}\t\t", .{i, j, cell});
        }
        print("\n", .{});
    }
}