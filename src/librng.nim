import librng/generator, 
       librng/algorithms/[
        xoroshiro128, splitmix64, lcg, mersenne_twister, 
        marsaglia_69069, lehmer64
       ],
       std/[times, tables, strformat, sysrand]

type
  ## An unrecoverable error that happens during the initialization of RNG.
  RNGInitializationDefect* = object of Defect

  ## An enum representing all of the algorithms that librng supports.
  RNGAlgorithm* = enum
    Xoroshiro128
    Lehmer64
    Marsaglia69069
    Splitmix64
    LCG
    MersenneTwister

  RNG* = ref object of RootObj
    seed*: uint64
    
    smix: Splitmix64
    generator: Generator

proc `$`*(rng: RNG): string {.inline.} =
  ## Converts a RNG helper object into a string representation.
  fmt"librng generator (seed: {rng.seed})"

proc initialize*(rng: RNG, algo: RNGAlgorithm) {.inline.} =
  ## Initializes a Splitmix64 base generator and the algorithm specified.
  ## You do not need to call this as `<#newRNG,RNGAlgorithm>`_ already calls it for you.
  rng.smix = newSplitmix64(rng.seed)
  case algo
  of Xoroshiro128:
    rng.generator = newXoroshiro128(
      rng.smix.next(),
      rng.smix.next()
    )
  of Lehmer64:
    rng.generator = newLehmer64(
      rng.smix.next()
    )
  of Marsaglia69069:
    rng.generator = newMarsaglia69069(
      rng.smix.next()
    )
  of LCG:
    rng.generator = newLinearCongruentialGenerator(
      rng.smix.next(),
      rng.smix.next(),
      rng.smix.next(),
      rng.smix.next()
    )
  of MersenneTwister:
    rng.generator = newMersenneTwister(
      rng.smix.next()
    )
  else: discard

proc gen(rng: RNG): uint64 {.inline.} =
  ## Simply generates an unsigned 64 bit integer from the generator.
  rng.generator.next()

proc randint*(rng: RNG, range: int = int.high): int {.inline.} =
  ## Generates an integer.
  # Article on generating random numbers within a range
  # https://www.pcg-random.org/posts/bounded-rands.html
  cast[int](rng.gen()) mod range

proc choice*[T](rng: RNG, arr: openArray[T]): T {.inline.} =
  ## Picks an item from an `openArray[T]`.
  var idx = rng.randint(arr.len)

  # This is a bad way of doing this!
  while idx < 0:
    idx = rng.randint(arr.len)

  arr[idx]

proc newRNG*(seed: uint64 = 0, algo: RNGAlgorithm = Xoroshiro128): RNG =
  ## Initializes a RNG helper.
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

  var rng = RNG(
    seed: realSeed
  )
  rng.initialize(algo)

  rng
