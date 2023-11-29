const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

// defer will execute an expression at the end of the current scope.
test "simple defer" {
    var a: u8 = 0;
    {
        // so 'a' will be allocated 10 end at the end of the current scope
        // therefore it will over write a = 2 ---> 10
        defer a = 10;
        a = 2;
    }
    try expect(a == 10); // a = 10
}

// If multiple defer statements are specified, they will be executed in
// the reverse order they were run.
test "defer basics" {
    print("\n", .{});

    defer {
        print("1\n", .{});
    }
    defer {
        print("2\t", .{});
    }
    if (false) {
        // defers are not run if they are never executed.
        defer {
            print("3\t", .{});
        }
    }
}

// Inside a defer expression the return statement is not allowed.
test "inside defer, return not allowed" {
    defer {
        // return error.DeferError;
    }
}

// The errdefer keyword is similar to defer, but will only execute if the
// scope returns with an error.
//
// This is especially useful in allowing a function to clean up properly
// on error, and replaces goto error handling tactics as seen in c.
fn deferErrorExample(is_error: bool) !void {
    print("\nstart of function\n", .{});

    // This will always be executed on exit
    defer {
        print("end of function\n", .{});
    }

    errdefer {
        print("encountered an error!\n", .{});
    }

    if (is_error) {
        return error.DeferError;
    }
}

// The errdefer keyword also supports an alternative syntax to capture the
// generated error.
//
// This is useful for printing an additional error message during clean up.
fn deferErrorCaptureExample() !void {
    errdefer |err| {
        std.debug.print("the error is {s}\n", .{@errorName(err)});
    }

    return error.DeferError;
}

test "errdefer unwinding" {
    deferErrorExample(false) catch {};
    deferErrorExample(true) catch {};
    deferErrorCaptureExample() catch {};
}

