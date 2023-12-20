const zaba_core = @import("zaba_core");
const zaba_arm = @import("zaba_arm");

pub fn main() !void {
    zaba_core.testing();
    zaba_arm.testing();
}
