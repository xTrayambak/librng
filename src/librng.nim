import librng/[xoroshiro128, splitmix64, generator, lcg, mersenne_twister, 
               marsaglia_69069, lehmer64, xoroshiro256starstar], 
    std/[times, tables, strformat, sysrand]

type
  RNGInitializationDefect* = Defect
  RNGAlgorithm* = enum
    rngXoroshiro128
    rngXoroshiro256SS
    rngLehmer64
    rngMarsaglia69069
    rngSplitmix64
    rngLCG
    rngMersenneTwister

  RNG* = ref object of RootObj
    seed*: uint64

    generators: TableRef[RNGAlgorithm, Generator]

proc `$`*(rng: RNG): string {.inline.} =
  fmt"librng generator (seed: {rng.seed}; loaded generators: {rng.generators.len})"

proc gen(rng: RNG, genAlgo: RNGAlgorithm): uint64 =
 if genAlgo in rng.generators:
  rng.generators[genAlgo].next()
 else:
  var gen: Generator

  if genAlgo == rngSplitmix64:
   gen = newSplitmix64(rng.seed)
  elif genAlgo == rngXoroshiro128:
    gen = newXoroshiro128(
      rng.gen(rngSplitmix64),
      rng.gen(rngSplitmix64)
    )
  elif genAlgo == rngLCG:
   gen = newLinearCongruentialGenerator(
    rng.gen(rngSplitmix64),
    rng.gen(rngSplitmix64),
    rng.gen(rngSplitmix64),
    rng.gen(rngSplitmix64)
   )
  elif genAlgo == rngMersenneTwister:
   gen = newMersenneTwister(
    rng.gen(rngSplitmix64)
   )
  elif genAlgo == rngXoroshiro256SS:
    gen = newXoroshiro256SS(
      rng.gen(rngSplitmix64),
      rng.gen(rngSplitmix64),
      rng.gen(rngSplitmix64),
      rng.gen(rngSplitmix64)
    )
  elif genAlgo == rngMarsaglia69069:
    gen = newMarsaglia69069(
      rng.gen(rngSplitmix64)
    )
  elif genAlgo == rngLehmer64:
    gen = newLehmer64(
      rng.gen(rngSplitmix64)
    )
  rng.generators[genAlgo] = gen
  rng.gen(genAlgo)

proc randint*(rng: RNG, range: int = int.high, 
              genAlgo: RNGAlgorithm = rngXoroshiro128
            ): int =
 # Article on generating random numbers within a range
 # https://www.pcg-random.org/posts/bounded-rands.html
 cast[int](rng.gen(genAlgo)) mod range

proc choice*[T](rng: RNG, arr: seq[T], 
  genAlgo: RNGAlgorithm = rngXoroshiro128
 ): T =
 var idx = rng.randint(arr.len, genAlgo)

 # This is a bad way of doing this!
 while idx < 0:
  idx = rng.randint(arr.len, genAlgo)

 arr[idx]

proc newRNG*(seed: uint64 = 0): RNG =
 var realSeed: uint64 = seed

 when defined(librngUseTimeBasedRNG) or defined(js):
  if seed == 0:
    realSeed = now().second.uint64 * 1000'u64 + now().minute.uint64 * 2048'u64
 else:
  when defined(nimscript):
   realSeed = cast[uint64](CompileTime.hash)
  else:
   var x: array[8, byte]
   for _ in 0..7:
    if urandom(x):
     copyMem(realSeed.addr, x[0].addr, 8)
    else:
     raise newException(RNGInitializationDefect, "urandom() syscall failed!")

 RNG(seed: realSeed, generators: newTable[RNGAlgorithm, Generator]())

export RNGAlgorithm, RNG
