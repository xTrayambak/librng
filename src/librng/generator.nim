type
  GeneratorWorkInProgressDefect* = Defect
  UninitializedGeneratorDefect* = Defect
  Generator* = ref object of RootObj
   seed*: uint64 # for single state algorithms like Splitmix64
   state*: array[0..64, uint64] # for multi-state algorithms like Xoroshiro128

method next*(generator: Generator): uint64 {.base inline.} =
 raise newException(UninitializedGeneratorDefect, "Generator does not implement a next() function")
