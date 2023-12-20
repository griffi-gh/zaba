pub const Condition = enum(u4) {
    /// Z=1           equal (zero) (same)
    eq,
    /// Z=0           not equal (nonzero) (not same)
    ne,
    /// C=1           unsigned higher or same (carry set)
    cs,
    /// C=0           unsigned lower (carry cleared)
    cc,
    /// N=1           signed negative (minus)
    mi,
    /// N=0           signed positive or zero (plus)
    pl,
    /// V=1           signed overflow (V set)
    vs,
    /// V=0           signed no overflow (V cleared)
    vc,
    /// C=1 and Z=0   unsigned higher
    hi,
    /// C=0 or Z=1    unsigned lower or same
    ls,
    /// N=V           signed greater or equal
    ge,
    /// N<>V          signed less than
    lt,
    /// Z=0 and N=V   signed greater than
    gt,
    /// Z=1 or N<>V   signed less or equal
    le,
    /// -             always (the "AL" suffix can be omitted)
    al,
    /// -             never (ARMv1,v2 only) (Reserved ARMv3 and up)
    nv,
};
