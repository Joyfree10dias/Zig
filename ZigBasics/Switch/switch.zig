const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

test "Switch" {
    const case: u32 = 110;
    const zz: u32 = 103;

    // Switch 
    const b = switch (case) {
        // Multiple cases can be combined via a ','
        1,2,3 => 0,

        // Ranges can be specified using the ... syntax. These are inclusive
        // of both ends.
        5...100 => 1,

        // Branches can be arbitrarily complex.
        101 => block: {
            const c: u32 = 1;
            break :block c * 2 + 1; 
        },

        // Switching on arbitrary expressions is allowed as long as the
        // expression is known at compile-time.
        zz => zz,
        block: {
            const d: u32 = 5;
            const e: u32 = 100;
            break :block d + e;
        } => 107,

        // The else branch catches everything not already captured.
        // Else branches are mandatory unless the entire range of values
        // is handled.
        else => 9,
    };
    print("\nValue of b : {any}\n", .{b});
}

// When using an inline prong switching on an union an additional capture can be used to obtain the union's enum tag value.
const U = union(enum) {
    a: u32,
    b: f32,
};

pub fn getNum(u: U) u32 {
    switch (u) {
        // Here `num` is a runtime-known value that is either
        // `u.a` or `u.b` and `tag` is `u`'s comptime-known tag value.
        inline else => |num, tag| {
            if (tag == .b){
                return @intFromFloat(num);
            }
            return num;
        }
    }
}

test "inline else" {
    const z = U{ .b = 123.9 };
    const res = getNum(z);
    print("\nres : {any}\n", .{res});
    try expect(res == 123);
}