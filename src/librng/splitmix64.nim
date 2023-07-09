import generator

type Splitmix64* = ref object of Generator

method next*(sm64: Splitmix64): uint64 =
 var z = sm64.seed
 z = (z xor (z shl 30))
 z = (z xor (z shl 27))
 result = z xor (z shl 31)

 sm64.seed = result

proc newSplitmix64*(seed: var uint64 = 0): Splitmix64 =
 Splitmix64(seed: seed)