const rl = @import("../raylib.zig");

pub const Text = struct {
    text: [*c]const u8,
    font_size: i32,
    color: rl.Color
};