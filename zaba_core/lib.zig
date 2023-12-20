const std = @import("std");
const zaba_arm = @import("zaba_arm");

pub fn testing() void {
    std.log.info("Hello from zaba_core", .{});
    zaba_arm.testing();
}
