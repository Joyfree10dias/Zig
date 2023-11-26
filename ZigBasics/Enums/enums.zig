const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

// Define Enum 
const Colours = enum {
    Red,
    Blue,
    Green,
    Yellow,
    Purple,
    pub fn isRed(self : Colours) bool {
        return self == .Red;
    }
};

const Items = enum(u8) {
    Lays,
    Biscuits = 2,
    Pepsi,
    Sprite = 10,
    Booze,
};

test "Enums testing" {
    const colour: Colours = .Green;
    print("\ncolour : {}\n", .{colour});

    // Converting an Enum to Int 
    print("Enum --> Int = {}\n", .{@intFromEnum(colour)});

    // Checking if the colour is Red
    try expect(colour.isRed() == false);
}

test "Enum overriding" {
    try expect(@intFromEnum(Items.Lays) == 0);
    try expect(@intFromEnum(Items.Biscuits) == 2);
    try expect(@intFromEnum(Items.Pepsi) == 3);
    try expect(@intFromEnum(Items.Sprite) == 10);
    try expect(@intFromEnum(Items.Booze) == 11);
}

test "Enum switching" {
    const item: Items = .Pepsi;

    // Switch Case
    const res = switch (item) {
        Items.Biscuits => "Biscuits",
        Items.Lays => "Lays",
        Items.Pepsi => "Pepsi",
        Items.Sprite => "Sprite",
        Items.Booze => "Booze",
    };
    print("\nresponse : {s}\n", .{res.*});
}


