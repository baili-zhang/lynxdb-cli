// Copyright 2024 Baili Zhang.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

const std = @import("std");

pub fn removeLeftWhitespace(list: *std.ArrayList(u8)) void {
    while (list.items.len != 0 and std.ascii.isWhitespace(list.getLast())) {
        _ = list.pop();
    }
}

pub fn equals(list: *std.ArrayList(u8), word: []const u8) bool {
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
    try std.testing.expect(equals(&line, "insert"));
}
