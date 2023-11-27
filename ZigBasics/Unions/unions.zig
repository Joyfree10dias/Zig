const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

// Define a Union 
const Payload = union {
    int: i64,
    float: f64,
    boolean: bool,
};

const Speed = union {
    distance : u16,
    time : u16,
};

// Define a Tagged union 
const complexTypeTag = enum {
    ok,
    not_ok,
};
// Pass the enum as a tag
const ComplexType = union(complexTypeTag) {
    ok: i8,
    not_ok: void,
};

test "Simple Union" {
    var payload = Payload{ .int = 1234 };
    try expect(payload.int == 1234);
    // You can activate another field by assigning the entire union
    payload = Payload{ .boolean = true };
    try expect(payload.boolean == true);
}

test "Tagged Union" {
    const c = ComplexType{ .ok = 10 };
    print("\nc : {any}\n", .{c});
    print("t1 : .{any} and t2 : {any}\n", .{@as(complexTypeTag, c),complexTypeTag.ok});
    try expect(@as(complexTypeTag, c) == complexTypeTag.ok);
}

test "switch on tagged unions" {
    const c = ComplexType{ .ok = 10 };
    switch (c) {
        complexTypeTag.ok => |value| print("\nvalue : {any}\n", .{value}),
        complexTypeTag.not_ok => unreachable,
    }

    // In order to modify the payload of a tagged union in a switch expression, 
    // place a * before the variable name to make it a pointer
    switch (c) {
        complexTypeTag.ok => |*value| print("updated value : {any}\n", .{value.*+1}),
        complexTypeTag.not_ok => unreachable,
    }

}

test "Anonymous Union " {
    const p = returnSomething();
    try expect(p.time == 50);
}

// This function anonymously returns a type from union
pub fn returnSomething() Speed {
    return Speed{ .time = 50 };
} 