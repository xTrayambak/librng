import unittest

import librng
test "rng":
  var rng = newRNG()
  echo $rng
  let fruits = @["apples", "oranges", "pineapples", "mangoes", "bananas"]

  echo "This is a fruit: " & rng.choice(fruits)