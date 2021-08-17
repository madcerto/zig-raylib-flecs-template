const flecs = @import("flecs");
const rl = @import("raylib");

pub fn draw_fps(it: *flecs.ecs_iter_t) callconv(.C) void {
    rl.DrawFPS(10,10);
}