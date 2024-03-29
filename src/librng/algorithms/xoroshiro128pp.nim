## Xoroshiro128++ implementation

import ../[shared, generator]

type Xoroshiro128PlusPlus* = ref object of Generator

method next*(xoroshiro: Xoroshiro128PlusPlus): uint64 {.inline.} =
  let s0 = xoroshiro.state[0]
  var s1 = xoroshiro.state[1]

  let res = rotl(s0 + s1, 17'u64) + s0

  s1 = s1 xor s0

  xoroshiro.state[0] = rotl(s0, 49'u64) xor s1 xor (s1 shl 21'u64)
  xoroshiro.state[1] = rotl(s1, 28'u64)

  res

proc newXoroshiro128PlusPlus*(s1, s2: uint64): Xoroshiro128PlusPlus {.inline.} =
  var state: array[0..64, uint64]
  state[0] = s1
  state[1] = s2
  Xoroshiro128PlusPlus(state: state)
