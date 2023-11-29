const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

test "Simple while" {
    var i: usize = 0;
    // While 
    while (i < 10) {
        i += 1;
    }
    print("\ni : {any}\n", .{i});
    try expect(i == 10);

    // use 'break' to break out of the loop
    i = 0;
    while (true) {
        if (i == 10) {
            break;
        }
        i += 1;
    }
    try expect(i == 10);

    // Use 'continue' to jump back to the beginning of the loop.
    i = 0;
    while (true) {
        i += 1;
        if (i < 10) {
            continue;
        }
        break;
    }
    try expect(i == 10);
}

// While loops support a continue expression which is executed when the loop is continued.
test "While loop continue expression" {
    var i: usize = 0;
    while (i < 10) : (i += 1) {}
    try expect(i == 10);

    // More complex 
    i = 1;
    var j: usize = 1;
    while (i * j < 1500) : ({ i *= 2; j *= 3; }) {
        const product = i * j;
        try expect(product < 1500);
    }
}

test "While else" {
    var hasNumber = rangeHasNumber(0, 10, 5);
    try expect(hasNumber == true);
    hasNumber = rangeHasNumber(0, 10, 15);
}

pub fn rangeHasNumber(start: usize, end: usize, number: usize) bool {
    var i = start;

    // break, like return, accepts a value parameter. This is the result of the while expression. 
    // When you break from a while loop, the else branch is not evaluated.
    const res = while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;

    return res;
}

test "Labeled while" {
    // When a while loop is labeled, it can be referenced from a break or continue from within a nested loop
    outer: while (true) {
        print("\nOuter\n", .{});
        while (true) {
            print("Inner\n", .{});
            break :outer;
        }
    }

    var i: usize = 0;
    outer: while (i < 10) : (i += 1) {
        while (true) {
            continue :outer;
        }
    }
    try expect(i == 10);
}

// When the else |x| syntax is present on a while expression, 
// the while condition must have an Error Union Type.
var num: usize = undefined;
pub fn eventuallyErrorSequence() anyerror!u32 {
    return if (num == 0) error.HasReachedZero else block: {
        num -= 1;
        break :block num;
    };
}

test "While error union capture" {
    var sum: u32 = 0;
    num = 3;
    while (eventuallyErrorSequence()) |value| {
        sum += value;
    }else |err| {
        try expect(err == error.HasReachedZero);
    }
    print("\nsum : {any}\n", .{sum});
    try expect(sum == 3);
}

test "Inline while loop" {
    comptime var i = 0;
    var sum: usize = 0;
    inline while (i < 3) : (i += 1) {
        const T = switch (i) {
            0 => f32,
            1 => u8,
            2 => bool,
            else => unreachable,
        };
        sum += typeNameLength(T);
    }
    try expect(sum == 9);
}

fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}

// For loops
test "for basics" {
    const items = [_]i32 { 4, 5, 3, 4, 0 };
    var sum: i32 = 0;

    // For loops iterate over slices and arrays.
    for (items) |value| {
        // Break and continue are supported.
        if (value == 0) {
            continue;
        }
        sum += value;
    }
    try expect(sum == 16);

    // To iterate over a portion of a slice, reslice.
    for (items[0..1]) |value| {
        sum += value;
    }
    try expect(sum == 20);

    // To access the index of iteration, specify a second condition as well
    // as a second capture value.
    var sum2: i32 = 0;
    for (items, 0..) |_, i| {
        try expect(@TypeOf(i) == usize);
        sum2 += @as(i32, @intCast(i));
    }
    try expect(sum2 == 10);

    // To iterate over consecutive integers, use the range syntax.
    // Unbounded range is always a compile error.
    var sum3: usize = 0;
    for (0..5) |i| {
        sum3 += i;
    }
    try expect(sum3 == 10);
}

test "multi object for" {
    const items = [_]usize{ 1, 2, 3 };
    const items2 = [_]usize{ 4, 5, 6 };
    var count: usize = 0;

    // Iterate over multiple objects.
    // All lengths must be equal at the start of the loop, otherwise detectable
    // illegal behavior occurs.
    for (items, items2) |i, j| {
        count += i + j;
    }

    try expect(count == 21);
}

test "for reference" {
    var Items = [_]u32 {1, 2, 3};
    // Iterate over the slice by reference by
    // specifying that the capture value is a pointer.
        print("\nItem address : {any}\n", .{&Items});
    for (&Items) |*value| {
        value.* += 1;
    }

    try expect(Items[0] == 2);
    try expect(Items[1] == 3);
    try expect(Items[2] == 4);

}

test "for else" {
    // For allows an else attached to it, the same as a while loop.
    const items = [_]?i32 { 3, 4, null, 5 };

    // For loops can also be used as expressions.
    // Similar to while loops, when you break from a for loop, the else branch is not evaluated.
    var sum: i32 = 0;
    const result = for (items) |value| {
        if (value != null) {
            sum += value.?;
        }
    } else block: {
        try expect(sum == 12);
        break :block sum;
    };
    try expect(result == 12);
}

// Labeled for and Inline for are similar to that of the while loop
test "Labeled for" {
    var count: usize = 0;
    outer: for (1..6) |_| {
        for (1..6) |_| {
            count += 1;
            break :outer;
        }
    }
    try expect(count == 1);

    count = 0;
    outer: for (1..9) |_| {
        for (1..6) |_| {
            count += 1;
            continue :outer;
        }
    }

    try expect(count == 8);
}