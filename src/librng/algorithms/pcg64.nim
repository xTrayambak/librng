## A PCG64 implementation (www.pcg-random.org)

import ../[shared, generator]

const MULTIPLIER = 6364136223846793005'u64

type PCG32* = ref object of Generator
  increment*: uint64

proc advance*(pcg: PCG32, delta: uint64) {.inline.} =
  var
    accMult = 1'u64
    accPlus = 0'u64
    currMult = MULTIPLIER
    currPlus = pcg.increment
    mdelta = delta

  while mdelta > 0:
    if (mdelta and 1'u64) == 0:
      accMult = accMult * currMult
      accPlus = accPlus * currMult + currPlus

    currPlus = (currMult + 1'u64) * currPlus
    currMult = currMult * currMult
    mdelta = mdelta div 2'u64

  pcg.seed = accMult * pcg.seed + accPlus

proc step*(pcg: PCG32) {.inline.} =
  pcg.seed = pcg.seed * MULTIPLIER + pcg.increment

method next*(pcg: PCG32): uint64 {.inline.} =
  let seed = pcg.seed
  step pcg

  const
    ROTATE = 59'u32
    XSHIFT = 18'u32
    SPARE = 27'u32

  let 
    rot = (seed shr ROTATE).uint32
    xsh = (((seed shr XSHIFT) xor seed) shr SPARE).uint32

  xsh.rotr(rot)

proc newPCG64*(seed: uint64): PCG32 {.inline.} =
  PCG32(
    seed: seed
  )
