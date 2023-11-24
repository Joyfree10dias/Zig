const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;

threadlocal var Number:i16 = 123;

test "thread local storage" {
    const thread1 = try std.Thread.spawn(.{}, addOne, .{});
    const thread2 = try std.Thread.spawn(.{}, addOne, .{});
    addOne();
    thread1.join();
    thread2.join();
}

pub fn addOne() void {
    assert(Number == 123);
    Number += 1;
    assert(Number == 124);
}