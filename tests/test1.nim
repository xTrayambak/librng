import unittest

import librng
test "choices":
  var rng = newRNG()
  echo $rng
  let fruits = @["apples", "oranges", "pineapples", "mangoes", "bananas"]
  let favourite = rng.choice(fruits)
