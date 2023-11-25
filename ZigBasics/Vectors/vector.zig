const std = @import("std");
const print = std .debug.print;

var vec = @Vector(5, i8) {1, 2, 3, 7, 6};
var FloatVec = @Vector(5, f16) {1.2, 1.3, 1.4, 1.5, 1.6};
var vec2 = @Vector(5, i8) {9, 8, 7, 6, 5};

pub fn main() !void {
    // Printing vector
    print("Vec : {any} and Vec2 : {any}\n", .{vec, vec2});

    // Printing float vector
    print("Float vec : {any}\n", .{FloatVec});

    // Vector addition
    const AddVec = vec + vec2;
    print("Add vec : {any}\n", .{AddVec});

    // Vector multiplication
    const MulVec = vec * vec2;
    print("Multiplication vec : {any}\n", .{MulVec});

    // Vector division
    const DivVec = vec2 / vec;
    print("Division vec : {any}\n", .{DivVec});

    // Vector substraction
    const SubVec = vec2 - vec;
    print("Substraction vec : {any}\n", .{SubVec});
}