pub const std = @import("std");
pub const reg = @import("reg.zig");
pub const cond = @import("cond.zig");

pub fn testing() void {
    std.log.info("Hello from zaba_arm", .{});
}

test {
    std.testing.refAllDecls(@This());
}
