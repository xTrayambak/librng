import ../generator

type Lehmer64* = ref object of Generator

method next*(lehmer64: Lehmer64): uint64 {.inline.} =
 lehmer64.seed *= 0xda942042e4dd58b5'u64
 let val = lehmer64.seed shr 64

 lehmer64.seed = val

 val

proc newLehmer64*(seed: uint64): Lehmer64 =
 Lehmer64(seed: seed)
