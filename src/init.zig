const std = @import("std");
const flecs = @import("flecs");
const rl = @import("raylib.zig");
const components = @import("components/export.zig");
const systems = @import("systems/export.zig");

pub fn init(world: *flecs.World, allocator: *std.mem.Allocator) std.mem.Allocator.Error!void {
    // add components and systems
    components.init(world);
    systems.init(world);

    // create raylib camera
    var rlcamera = try allocator.create(rl.Camera);
    rlcamera.* = rl.Camera {
        .position = rl.Vector3{ .x = 5, .y = 4, .z = 5 },
        .target = rl.Vector3{ .x = 0, .y = 2, .z = 0 },
        .up = rl.Vector3{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE
    };

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
    // raylib deallocations can also go here, by doing a query on world, or add triggers for those
    arena.deinit();
}