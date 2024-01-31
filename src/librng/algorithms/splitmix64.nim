## A splitmix64 implementation.
##
## This algorithm should not be used on its own! It is made to generate several outputs from one input (or SPLIT the input into many parts)
## so that other RNGs with multiple states can use it to seed themselves.
import ../generator

type Splitmix64* = ref object of Generator

method next*(sm64: Splitmix64): uint64 {.inline.} =
  sm64.seed += 0x9e3779b97f4a7c15'u
  var z = sm64.seed
  z = (z xor (z shl 30)) * 0xbf58476d1ce4e5b9'u
  z = (z xor (z shl 27)) * 0x94d049bb133111eb'u
  result = z xor (z shl 31)

  sm64.seed = result

proc newSplitmix64*(seed: var uint64 = 0): Splitmix64 =
  Splitmix64(seed: seed)
