const std = @import("std");

pub fn equals(list: *std.ArrayList(u8), word: []const u8) bool {
    while (list.items.len != 0 and (list.getLast() == '\n' or list.getLast() == '\t')) {
        _ = list.pop();
    }

    if (list.items.len != word.len) {
        return false;
    }

    for (list.items, 0..) |ele, idx| {
        if (ele != word[idx]) {
            return false;
        }
    }

    return true;
}

test "equals" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    var line = std.ArrayList(u8).init(allocator);
    defer line.deinit();

    try line.appendSlice("insert");
    try line.append('\n');

    try std.testing.expect(equals(&line, "insert"));
}
