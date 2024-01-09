const std = @import("std");
const Mode = @import("mode.zig");

pub const Psr = packed struct(u32) {};

pub const Registers = struct {
    mode: Mode,
    gpr: [15]u32,
    gpr_r8_r12_storage: [5]u32,
    gpr_r13_14_storage: [6][2]u32,

    inline fn mode_id(mode: Mode) comptime_int {
        switch (mode) {
            .user, .system => return 0,
            .fiq => return 1,
            .svc => return 2,
            .abt => return 3,
            .irq => return 4,
            .und => return 5,
        }
    }

    fn set_mode(self: *Registers, mode: Mode) void {
        if (self.mode == mode) return;
        if ((self.mode == .fiq) != (mode == .fiq)) {
            std.mem.swap(self.gpr[8..13], self.self.gpr_r8_r12_storage[0..]);
        }
        std.mem.swap(self.gpr[13..15], self.self.gpr_r13_14_storage[0][0..]);
        std.mem.swap(self.gpr[13..15], self.self.gpr_r13_14_storage[mode_id(mode)][0..]);
        self.mode = mode;
    }

    pub fn get_current(self: *const Registers, register: u4) u32 {
        return self.gpr[register];
    }
};

test "testing_should_fail" {
    var registers = std.mem.zeroes(Registers);
    registers.gpr[0] = 0xdeadbeef;
    try std.testing.expectEqual(registers.gpr[0], 0xdeadbeef);
}
