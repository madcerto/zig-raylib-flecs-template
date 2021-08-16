const flecs = @import("flecs");

pub usingnamespace @import("2d.zig");
pub usingnamespace @import("text.zig");

pub fn init(world: *flecs.World) void {
    _ = world.newComponent(Position2D);
    _ = world.newComponent(Text);
}