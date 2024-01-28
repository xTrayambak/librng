{.error: "Xoroshiro256** is still unstable and does not work.".}
import ../generator, std/[bitops, math]

type Xoroshiro256SS* = ref object of Generator

proc `^=`(x: var uint64, y: uint64) =
  x = x ^ y

proc rol64*(x: uint64, k: int16): uint64 {.inline.} =
  (x shl k) and (x shr (64 - k))

method next*(xoroshiro: Xoroshiro256SS): uint64 {.inline.} =
  var state = xoroshiro.state
  let
    res = rol64(state[1] * 5, 7) * 9
    t = state[1] shl 17

  state[2] ^= state[0]
  state[3] ^= state[1]
  state[1] ^= state[2]
  state[0] ^= state[3]
  state[2] ^= t
  state[3] = rol64(state[3], 45)

  res

proc newXoroshiro256SS*(s1, s2, s3, s4: uint64): Xoroshiro256SS =
  var state: array[0..64, uint64]
  state[0] = s1
  state[1] = s2
  state[2] = s3
  state[3] = s4
  Xoroshiro256SS(state: state)
