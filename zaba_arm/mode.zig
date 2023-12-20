pub const Mode = enum(u5) {
    user = 0b0000,
    fiq = 0b0001,
    irq = 0b0010,
    svc = 0b10011,
    abt = 0b10111,
    und = 0b11011,
    system = 0b11111,
};
