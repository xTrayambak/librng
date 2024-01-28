import ../generator

type
  LinearCongruentialGenerator* = ref object of Generator
    modulus: uint64
    mult: uint64
    incr: uint64

method next*(lcg: LinearCongruentialGenerator): uint64 {.inline.} =
  var res = ((lcg.seed * lcg.mult) + lcg.incr) mod lcg.modulus
  lcg.seed = res

  lcg.seed

proc newLinearCongruentialGenerator*(
    seed, modulus, mult, incr: uint64
): LinearCongruentialGenerator =
  LinearCongruentialGenerator(seed: seed, modulus: modulus, mult: mult, incr: incr)
