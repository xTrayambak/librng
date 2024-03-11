import unittest

import librng
import ./shared

suite "xoroshiro128":
  var rng = newRNG(algo = Xoroshiro128)
  test "numbers":
    for n in 0..32:
      echo '#' & $n & ": " & $rng.randint(32)

  test "choices":
    for _ in 0..32:
      echo "My favourite fruit is: " & rng.choice(FRUITS)

    for _ in 0..32:
      echo "My favourite Nim programmer is: " & rng.choice(COOL_PEOPLE)

    for _ in 0..32:
      echo "My favourite programming language is: " & rng.choice(LANGUAGES)
