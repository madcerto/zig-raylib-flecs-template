const flecs = @import("flecs");
const rl = @import("../raylib.zig");
const components = @import("../components/export.zig");

pub fn draw_text(it: *flecs.ecs_iter_t) callconv(.C) void {
    const texts = it.column(components.Text, 1);
    const positions = it.column(components.Position2D, 2);

    var i: usize = 0;
    while (i < it.count) : ( i += 1 ) {
        const text = texts[i].text;
        const font_size = texts[i].font_size;
        const color = texts[i].color;
        const pos = positions[i];

        rl.DrawText(text, @floatToInt(i32, pos.x), @floatToInt(i32, pos.y), font_size, color);
    }
}