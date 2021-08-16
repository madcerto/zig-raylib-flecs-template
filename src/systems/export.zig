const flecs = @import("flecs");

pub usingnamespace @import("rl_frame.zig");
pub usingnamespace @import("draw_fps.zig");
pub usingnamespace @import("draw_text.zig");

pub fn init(world: *flecs.World) void {
    _ = world.newSystem("Setup Rendering", .pre_store, "", setup_render);

    _ = world.newSystem("Draw FPS", .on_store, "", draw_fps);
    _ = world.newSystem("Draw Text", .on_store, "Text, Position2D", draw_text);

    _ = world.newSystem("End Frame", .post_frame, "", end_frame);
}