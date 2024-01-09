const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zaba_arm = b.addModule("zaba_arm", .{
        .root_source_file = .{ .path = "zaba_arm/lib.zig" },
    });

    const zaba_core = b.addModule("zaba_core", .{
        .root_source_file = .{ .path = "zaba_core/lib.zig" },
        .imports = &.{
            .{ .name = "zaba_arm", .module = zaba_arm },
        },
    });

    const exe = b.addExecutable(.{
        .name = "zaba",
        .root_source_file = .{ .path = "zaba/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("zaba_arm", zaba_arm);
    exe.root_module.addImport("zaba_core", zaba_core);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "");
    run_step.dependOn(&run_cmd.step);

    //Unit tests:

    const zaba_core_test = b.addTest(.{
        .name = "zaba_core_test",
        .root_source_file = .{ .path = "zaba_core/lib.zig" },
        .target = target,
        .optimize = optimize,
    });
    const zaba_core_test_run = b.addRunArtifact(zaba_core_test);

    const zaba_arm_test = b.addTest(.{
        .name = "zaba_arm_test",
        .root_source_file = .{ .path = "zaba_arm/lib.zig" },
        .target = target,
        .optimize = optimize,
    });
    const zaba_arm_test_run = b.addRunArtifact(zaba_arm_test);

    const test_step = b.step("test", "");
    test_step.dependOn(&zaba_core_test_run.step);
    test_step.dependOn(&zaba_arm_test_run.step);
}
