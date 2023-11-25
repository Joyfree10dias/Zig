const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

pub fn main() void {
    var x:u16 = 123;

    // Defining pointer - single pointer
    const ptr = &x;
    print("ptr address: {} and value : {}\n", .{ptr, ptr.*});
    
    // mutating the value using ptr
    ptr.* += 3; 
    print("ptr address: {} and value : {}\n", .{ptr, ptr.*});

    // Type 
    print("ptr type : {}\n", .{@TypeOf(ptr)});

    // ptr to an array 
    var array = [5]u8 {1, 91, 3, 4, 5};
    const array_ptr = &array;
    print("array ptr : {*} and corresponding array value : {any}\n",.{array_ptr, array_ptr.*});

    // many item-pointer
    var many_item_ptr: [*]const u8 = &array;
    print("many item ptr : {*} and corresponding array value : {}\n", .{many_item_ptr, many_item_ptr[0]});

    // pointer arithmetic
    many_item_ptr += 1; 
    print("many item ptr : {*} and corresponding array value : {any}\n",.{many_item_ptr, many_item_ptr[0]});
    many_item_ptr += 1; 
    print("many item ptr : {*} and corresponding array value : {any}\n",.{many_item_ptr, many_item_ptr[0]});

    // pointer arithmetic with slices
    const length :usize = 0;
    const slice = array[length..array.len];
    print("slice : {any} and type : {}\n", .{slice, @TypeOf(slice)});
    print("slice first value : {any}\n", .{slice[0]});
    print("slice ptr type : {any}\n", .{@TypeOf(slice.ptr)});   

    // accessing next value 
    print("slice next value : {any}\n", .{(slice.ptr + 1)[0]});

    // convert an integer address into a pointer
    print("type of Int : {any} and value : {}\n", .{@TypeOf(0xdeadbee0), 0xdeadbee0});
    const Int_ptr: *i32 = @ptrFromInt(0xdeadbee0);
    print("Int_ptr : {any}\n", .{Int_ptr});

    // convert a pointer to an integer
    const address = @intFromPtr(Int_ptr);
    print("address : {d} and type : {any}\n", .{address, @TypeOf(address)});
    
}

// Testing if the conversion is correct
test "@intFromPtr" {

    // convert an integer address into a pointer
    const Int_ptr: *i32 = @ptrFromInt(0xdeadbee0);

    // convert a pointer to an integer
    const address = @intFromPtr(Int_ptr);
    try expect(address == 0xdeadbee0);
    try expect(usize == usize);
}