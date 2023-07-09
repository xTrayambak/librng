import unittest

import librng
test "rng":
  var rng = newRNG()
  echo $rng
  for _ in 0..32:
    echo $rng.randint(range = 32, genAlgo = rngLCG)