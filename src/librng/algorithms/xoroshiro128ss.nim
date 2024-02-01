## Xoroshiro128** implementation

import std/bitops, ../[shared, generator]

type Xoroshiro128StarStar* = ref object of Generator

method next*(xoroshiro: Xoroshiro128StarStar): uint64 {.inline.} =
  let s0 = xoroshiro.state[0]
  var s1 = xoroshiro.state[1]

  let res = rotl(s0 * 5, 7'u64) * 9'u64

  s1 = s1 xor s0
  xoroshiro.state[0] = rotl(s0, 24) xor s1 xor (s1 shl 16'u64)
  xoroshiro.state[1] = rotl(s1, 37)

  res

proc newXoroshiro128StarStar*(s1, s2: uint64): Xoroshiro128StarStar =
  var state: array[0..64, uint64]
  state[0] = s1
  state[1] = s2
  Xoroshiro128StarStar(state: state)
