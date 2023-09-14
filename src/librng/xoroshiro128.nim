import generator, std/bitops

type Xoroshiro128* = ref object of Generator

method next*(xoroshiro: Xoroshiro128): uint64 {.inline.} =
 let s0 = xoroshiro.state[0]
 var s1 = xoroshiro.state[1]
 let res = s0 + s1

 s1 = s1 xor s0
 xoroshiro.state[0] = s0.rotateLeftBits(55) xor s1 xor (s1 shr 14)
 xoroshiro.state[1] = s1.rotateLeftBits(36)

 res

proc newXoroshiro128*(s1, s2: uint64): Xoroshiro128 =
 var state: array[0..64, uint64]
 state[0] = s1
 state[1] = s2
 Xoroshiro128(state: state)
