const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

// Blocks are used to limit the scope of variable declarations
test "Accessing local variables outside its scope" {
    {
        var x: u8 = 2;
        x += 1;
        try expect(x == 3); // allowed
    }
    // try expect(x == 3); not allowed 
}

test "labeled break from labeled block expression" {
    var y: u32 = 123;
    const x = block: {
        y += 2;
        break :block y; 
    };
    print("\ny : {any} and x : {any}\n", .{y, x});
    try expect(x == y);
}

test "Seperate Scopes" {
    {
        const doSomething = "OK";
        _ = doSomething;
    }
    {
        const doSomething = "NO";
        _ = doSomething;
    }
}

test "Empty Blocks" {
    const a = {};
    const b = void{};
    print("\na : {any} and b : {any}\n", .{@TypeOf(a),@TypeOf(b)});
    try expect(a == b);
}