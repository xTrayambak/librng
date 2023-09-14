#[
 Mersenne Twister implementation
]#
import generator

const
 NN* = 312
 MM* = 156
 MATRIX_A* = 0xB5026F5AA96619E9'u64
 UM* = 0xFFFFFFFF80000000'u64
 LM* = 0x7FFFFFFF'u64

proc temper(x: var uint64): uint64 {.inline.} =
 x = x xor (x shr 29) and 0x5555555555555555'u64
 x = x xor (x shl 17) and 0x71D67FFFEDA60000'u64
 x = x xor (x shl 37) and 0xFFF7EEE000000000'u64
 x = x xor (x shr 43)
 x

proc untemper(x: var uint64): uint64 {.inline.} =
 # reverse x xor (x shr 43)
 x = x xor (x shr 43)

 # reverse x xor (x shl 37) and 0xFFF7EEE000000000
 x = x xor (x shl 37) and 0xFFF7EEE000000000'u64

 # reverse x xor (x shl 17) and 0x71D67FFFEDA60000
 x = x xor (x shl 17) and 0x00000003eda60000'u64
 x = x xor (x shl 17) and 0x00067ffc00000000'u64
 x = x xor (x shl 17) and 0x71d0000000000000'u64

 # reverse x xor (x shr 29) and 0x5555555555555555
 x = x xor (x shr 29) and 0x0000000555555540'u64
 x = x xor (x shr 29) and 0x0000000000000015'u64

 x

type MersenneTwister* = ref object of Generator
 idx: uint
 mtState: array[NN, uint64]

proc fillNextState*(mt: MersenneTwister) {.inline.} =
 # WARNING: an unholy amount of type conversions ahead.
 # TODO(xTrayambak): make this more readable.
 for i in 0..NN-MM-1:
  let x = (mt.mtState[i] and UM) or (mt.mtState[i+1].uint64 and LM.uint64)
  mt.mtState[i] = cast[uint64](mt.mtState[i+MM].uint64 xor (x shr 1).uint64 xor ((x and 1) * MATRIX_A))

 for i in NN-MM..NN-2:
  let
   x = (mt.mtState[i] and UM).uint64 or (mt.mtState[i+1].uint64 and LM)

  mt.mtState[i] = cast[uint64](
   mt.mtState[i+MM-NN].uint64 xor (x shr 1).uint64 xor ((x and 1).uint64 * MATRIX_A)
  )

 let x = (mt.mtState[NN-1] and UM).uint64 or (mt.mtState[0] and LM)
 mt.mtState[NN-1] = cast[uint64](mt.mtState[MM-1] xor (x shr 1) xor ((x and 1).uint64 * MATRIX_A).uint64)
 mt.idx = 0

method next*(mt: MersenneTwister): uint64 {.inline.} =
 # raise newException(GeneratorWorkInProgressDefect, "Mersenne Twister is still work-in-progress. Consider helping out if you want. Sorry!")
 if mt.idx == 0:
  raise newException(UninitializedGeneratorDefect, "next() called without initializing generator!")

 if mt.idx >= NN:
  mt.fillNextState()

 var x = mt.mtState[mt.idx]
 inc mt.idx

 temper(x)

proc newMersenneTwister*(seed: uint64): MersenneTwister =
 var state: array[NN, uint64]

 state[0] = seed

 for i in 1..NN-1:
  state[i] = 6364136223846793005'u64 * (state[i-1] xor (state[i-1] shr 62)) + cast[uint64](i)

 MersenneTwister(
  idx: NN,
  seed: seed,
  mtState: state
 )
