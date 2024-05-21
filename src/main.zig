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
const utils = @import("./utils.zig");

const COPYRIGHT = "LynxDB Client Version {s}\nAll Right Reserved (c) Baili Zhang.\n\n";
const VERSION = "2024.5.3";
const PROMPT = "LynxDB-cli>";
const COLUMN_FAMILY = "Column Family: ";
const COLUMN = "Column: ";
const KEY_VALUE_PAIRS = "Key Value Pairs: ";
const INSERT = "insert";
const EXIT = "exit";
const ERROR = "Error: ";
const INVALID_COMMAND = "Invalid Command";

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print(COPYRIGHT, .{VERSION});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var isExited: bool = false;
    while (!isExited) {
        try stdout.print(PROMPT, .{});

        var line = std.ArrayList(u8).init(allocator);
        defer line.deinit();

        _ = try stdin.readUntilDelimiterArrayList(&line, '\n', 1024);

        if (utils.equals(&line, EXIT)) {
            isExited = true;
        }
    }
}
