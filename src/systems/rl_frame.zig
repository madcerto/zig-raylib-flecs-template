const flecs = @import("flecs");
const rl = @import("raylib");

pub fn setup_render(it: *flecs.ecs_iter_t) callconv(.C) void {
    rl.BeginDrawing();

    rl.ClearBackground(rl.SKYBLUE);
}

pub fn end_frame(it: *flecs.ecs_iter_t) callconv(.C) void {
    rl.EndDrawing();
}