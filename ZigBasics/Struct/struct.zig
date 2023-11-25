const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

const Square = struct {
    // Data members
    length: u32,

    // Member function
    // Initialise
    pub fn init(L: u32) @This() {
        return @This() {
            .length = L,
        };
    }

    // Calculate Area  
    pub fn CalArea(self: @This()) u32 {
        return  self.length * self.length;
    }
};

pub fn main() !void {

    // Using member function 'init'
    const s1 = Square.init(20);
    print("s1 : {any} and length : {}\n", .{s1, s1.length});
    const Area1 = s1.CalArea();
    print("Area : {}\n", .{Area1});

    // Another way of intialising
    const s2 = Square{
        .length = 10,
    };
    print("s2 : {any} and length : {}\n", .{s2, s2.length});
    const Area2 = s2.CalArea();
    print("Area : {}\n", .{Area2});

    // Printing Size
    print("Size of Square structure : {any}\n", .{@sizeOf(Square)});
    
}

test "Square structure" {
    const s = Square.init(30);
    print("Length : {}", .{s.length});
    try expect(30 == s.length);
    try expect(900 == s.CalArea());
}

test "Testing tuples" {
    // Tuples
    const values = .{
        @as(u64,  12345),
        @as(f64, 12345.67),
        true,
        "mom",
    } ++ .{false} ** 2;
    try expect(values[0] == 12345);
    try expect(values[1] == 12345.67);
    // another way of accessing data inside tuple
    try expect(values.@"2" == true);
    try expect(values.@"3"[0] == 'm');
    try expect(values.@"4" == false);
}