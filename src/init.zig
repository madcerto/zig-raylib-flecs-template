const std = @import("std");
const flecs = @import("flecs");
const rl = @import("raylib.zig");
const components = @import("components/export.zig");
const systems = @import("systems/export.zig");

pub fn init(world: *flecs.World, allocator: *std.mem.Allocator) std.mem.Allocator.Error!void {
    // add components and systems
    components.init(world);
    systems.init(world);

    // add entities
    const ehello_world = world.new();
    world.set(ehello_world, &components.Text {
        .text = "Hello, world!",
        .font_size = 100,
        .color = rl.BLACK
    });
    world.set(ehello_world, &components.Position2D {
        .x = 200,
        .y = 200
    });
}

pub fn deinit(world: *flecs.World, arena: *std.heap.ArenaAllocator) void {
    // raylib deallocations can also go here, by doing a query on world, or just add triggers for those
    arena.deinit();
}