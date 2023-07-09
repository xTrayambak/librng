import std/[times, random, strutils, os, strformat, strutils], librng

proc error =
 echo "./benchmark <test frequency> <algorithm to be used by librng (std/random only supports xoroshiro128+)>"
 quit 1

if paramCount() < 1:
  error()

var testFreq: int

if paramStr(1).toLowerAscii() == "max":
 testFreq = int.high
else:
 testFreq = paramStr(1)
   .parseInt()

var algo: RNGAlgorithm

if paramCount() < 2:
 case paramStr(2).toLowerAscii():
  of "xoroshiro":
   algo = rngXoroshiro
  of "lcg":
   algo = rngLCG
  else:
   echo "warning: no valid algorithm specified, librng will use Xoroshiro128"
   algo = rngXoroshiro
else:
 echo "warning: no algorithm specified, librng will use Xoroshiro128"
 algo = rngXoroshiro
 
proc getRandStd: seq[int] =
 randomize()
 var res: seq[int] = @[]
 
 for _ in 0..testFreq:
  res.add(rand(32))

 res

proc getRandLibrng: seq[int] =
 var
  res: seq[int] = @[]
  rng = newRNG()

 for _ in 0..testFreq:
  res.add(rng.randint())

 res

echo fmt"Benchmark (iterations={testFreq})"

let startTimeStd = cpuTime()
discard getRandStd()
let timeTakenStd = cpuTime() - startTimeStd

let startTimeLibrng = cpuTime()
discard getRandLibrng()
let timeTakenLibrng = cpuTime() - startTimeLibrng

echo fmt"std/random: {timeTakenStd} seconds"
echo fmt"librng: {timeTakenLibrng} seconds"