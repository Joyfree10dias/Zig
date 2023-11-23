const print = @import("std").debug.print;

pub fn TestingVariables() !void {
    var A: i16 = 255;
    A = A + 1;
    print("Value of A: {} and type : {}\n", .{ A, @TypeOf(A) });

    const B: ?[]const u8 = null;
    print("Value of B: {any} and type : {}\n", .{B, @TypeOf(B)});

    const C: anyerror!i16 = error.ArgNotFound;
    print("Value of C: {any} and type : {}\n", .{C, @TypeOf(C)});

}

pub fn main() !void {
    try TestingVariables();
}
