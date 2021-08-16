const std = @import("std");

const raylibFlags = &[_][]const u8{
    "-std=gnu99",
    "-DPLATFORM_DESKTOP",
    "-DGL_SILENCE_DEPRECATION",
    "-fno-sanitize=undefined", // https://github.com/raysan5/raylib/issues/1891
};
const flecsFlags = &[_][]const u8{
    "-Wall",
    "-Wextra",
    "-Werror",
};

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("simple-shooter", "src/main.zig");
    exe.addBuildOption(
        bool,
        "debug_collision",
        b.option(bool, "debug_collision", "Visible Collision Shapes") orelse false,
    );

    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.linkLibC();
    exe.addIncludeDir("./lib/raylib/src");
    exe.addIncludeDir("./lib/raylib/src/external/glfw/include");
    exe.addCSourceFile("./lib/raylib/src/core.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/models.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/raudio.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/shapes.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/text.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/textures.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/utils.c", raylibFlags);
    exe.addCSourceFile("./lib/raylib/src/rglfw.c", raylibFlags);

    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("rt");
    exe.linkSystemLibrary("dl");
    exe.linkSystemLibrary("m");
    exe.linkSystemLibrary("X11");

    exe.addIncludeDir("./lib/zig-flecs/flecs");
    exe.addCSourceFile("./lib/zig-flecs/flecs/flecs.c", flecsFlags);
    // exe.addObjectFile("./flecs/flecs.o");
    exe.addPackagePath("flecs", "./lib/zig-flecs/src/flecs.zig");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
