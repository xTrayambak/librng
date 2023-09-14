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

if paramCount() > 1:
 case paramStr(2).toLowerAscii():
  of "xoroshiro128":
   algo = rngXoroshiro128
  of "xoroshiro256**":
   algo = rngXoroshiro256SS
  of "lcg":
   algo = rngLCG
  of "m69069":
   echo "nice."
   algo = rngMarsaglia69069
  of "lehmer64":
   algo = rngLehmer64
  of "mersenne_twister":
   algo = rngMersenneTwister
  else:
   echo "warning: no valid algorithm specified, librng will use Xoroshiro128"
   algo = rngXoroshiro128
else:
 echo "warning: no algorithm specified, librng will use Xoroshiro128"
 algo = rngXoroshiro128
 
proc getRandStd =
 randomize()
 
 for _ in 0..testFreq:
  discard rand(32)

proc getRandLibrng =
 var rng = newRNG()

 for _ in 0..testFreq:
  discard rng.randint(32)

echo fmt"Benchmark (iterations={testFreq})"

let startTimeStd = cpuTime()
getRandStd()
let timeTakenStd = cpuTime() - startTimeStd

let startTimeLibrng = cpuTime()
getRandLibrng()
let timeTakenLibrng = cpuTime() - startTimeLibrng

echo fmt"std/random: {timeTakenStd} seconds"
echo fmt"librng: {timeTakenLibrng} seconds"
