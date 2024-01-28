import librng

var
  xoroshiro128 = newRNG(algo = Xoroshiro128)
  lehmer64 = newRNG(algo = Lehmer64)
  mersenne = newRNG(algo = MersenneTwister)
  marsaglia = newRNG(algo = Marsaglia69069)

const
  libraries = [
    "pixie", "fidget", "chame", "nimlsp", "jsony", "librng", "gintro", "owlkettle",
    "nimcrypto"
  ]

echo "Xoroshiro128 likes: " & xoroshiro128.choice(libraries)
echo "Lehmer64 likes: " & lehmer64.choice(libraries)
echo "Mersenne Twister likes: " & mersenne.choice(libraries)
echo "Marsaglia69069 likes: " & marsaglia.choice(libraries)
