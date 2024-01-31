## The base class from which all PRNG algorithms derive themselves from. It simply implements a `next` function as a base.

type
  GeneratorWorkInProgressDefect* = object of Defect
  UninitializedGeneratorDefect* = object of Defect
  Generator* = ref object of RootObj
    seed*: uint64 # for single state algorithms like Splitmix64
    state*: array[0..64, uint64] # for multi-state algorithms like Xoroshiro128

method next*(generator: Generator): uint64 {.base, inline.} =
  raise newException(
      UninitializedGeneratorDefect, "Generator does not implement a next() function"
  )
