import librng

let
  fruits =
    @[
      "apples", "bananas", "mangoes", "oranges", "pineapples", "litchees",
      "blueberries", "blackberries"
    ]

var rng = newRNG()

echo "My favourite fruit is: " & rng.choice(fruits)
