const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;


// Declare a function - Square functions which returns a square
pub fn Square(number: u32) u32 {
    return number * number;
}

test "function" {
    try expect(Square(12) == 144);
}

// Pass by value
fn add(x: u8, y: u8) u8 {
    // When we pass by reference the parameters are immutable
    print("\nAddress of local variable x: {any} and y: {any}\n", .{&x, &y});
    return x + y;
}

// Pass by reference
fn multiply(x: *u8, y: *u8) u8{
    print("\nAddress of local variable x: {any} and y: {any}\n", .{x, y});
    // When we pass by reference the parameters are mutable
    x.* += 1;
    y.* -= 1; 
    return x.* * y.*;
}


test "Pass by value and reference" {
    var a: u8 = 2;
    var b: u8 = 3;
    print("\n\nAddress of variable a: {any} and b: {any}\n", .{&a, &b});

    // Pass by value
    try expect(add(a, b) == 5);
    print("Values of variable a: {any} and b: {any}\n", .{a, b});

    // Pass by reference
    try expect(multiply(&a, &b) == 6);
    print("Values of variable a: {any} and b: {any}\n", .{a, b});
}

// Function Parameter Type Inference 
fn takeSomething(x: anytype) @TypeOf(x) {
    return x;
}

test "Function parameter type inference" {
    try expect(takeSomething(12) == 12);
    try std.testing.expectEqualStrings("Hello World", takeSomething("Hello World"));
}