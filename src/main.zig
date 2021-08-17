const std = @import("std");
const rl = @import("raylib.zig");
const flecs = @import("flecs");
const init = @import("init.zig");
const components = @import("components/export.zig");

pub fn main() !void {
    // FLECS initialization
    var world = flecs.World.init();
    defer world.deinit();
    world.setTargetFps(60);

    // raylib initialization
    const screen_width = 1600;
    const screen_height = 600;
    rl.InitWindow(screen_width, screen_height, "Title");
    defer rl.CloseWindow();
    rl.SetTargetFPS(60);

    // game initialization
    var buffer: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var arena = std.heap.ArenaAllocator.init(&fba.allocator);
    const allocator = &arena.allocator;

    try init.init(&world, allocator);
    defer init.deinit(&world, &arena);

    // Main game loop
    while (!rl.WindowShouldClose()) {
        world.progress(0);
    }
}