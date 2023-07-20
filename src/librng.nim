import librng/[xoroshiro, splitmix64, generator, lcg, mersenne_twister], 
    std/[times, tables, strformat]

type
  RNGAlgorithm* = enum
    rngXoroshiro
    rngSplitmix64
    rngLCG
    rngMersenneTwister

  RNG* = ref object of RootObj
    seed*: uint64

    generators: TableRef[RNGAlgorithm, Generator]

proc `$`*(rng: RNG): string =
  fmt"librng generator (seed: {rng.seed}; loaded generators: {rng.generators.len})"

proc gen(rng: RNG, genAlgo: RNGAlgorithm): uint64 =
 if genAlgo in rng.generators:
  rng.generators[genAlgo].next()
 else:
  var gen: Generator

  if genAlgo == rngSplitmix64:
   gen = newSplitmix64(rng.seed)
  elif genAlgo == rngXoroshiro:
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

  rng.generators[genAlgo] = gen
  rng.gen(genAlgo)

proc randint*(rng: RNG, range: int = int.high, 
              genAlgo: RNGAlgorithm = rngXoroshiro
            ): int =
 # Article on generating random numbers within a range
 # https://www.pcg-random.org/posts/bounded-rands.html
 cast[int](rng.gen(genAlgo)) mod range

proc choice*[T](rng: RNG, arr: seq[T], 
  genAlgo: RNGAlgorithm = rngXoroshiro
 ): T =
 var idx = rng.randint(arr.len, genAlgo)

 # This is a bad way of doing this!
 while idx < 0:
  idx = rng.randint(arr.len, genAlgo)

 arr[idx]

proc newRNG*(seed: uint64 = 0): RNG =
 var realSeed: uint64 = seed
 if seed == 0:
  realSeed = now().second.uint64 + now().minute.uint64

 RNG(seed: realSeed, generators: newTable[RNGAlgorithm, Generator]())

export RNGAlgorithm, RNG