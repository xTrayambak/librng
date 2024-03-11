import librng

var
  xoroshiro128 = newRNG(algo = Xoroshiro128)
  lehmer64 = newRNG(algo = Lehmer64)
  mersenne = newRNG(algo = MersenneTwister)
  marsaglia = newRNG(algo = Marsaglia69069)
  lcg = newRNG(algo = LCG)
  smix64 = newRNG(algo = Splitmix64)
  pcg = newRNG(algo = PCG)

const
  libraries = [
    "pixie", "fidget", "chame", "nimlsp", "jsony", "librng", "gintro", "owlkettle",
    "nimcrypto", "netty", "puppy", "happyx", "jester", "httpbeast", "modernnet"
  ]

echo "Xoroshiro128 likes: " & xoroshiro128.choice(libraries)
echo "Lehmer64 likes: " & lehmer64.choice(libraries)
echo "Mersenne Twister likes: " & mersenne.choice(libraries)
echo "Marsaglia69069 likes: " & marsaglia.choice(libraries)
echo "LCG likes: " & lcg.choice(libraries)
echo "Splitmix64 likes: " & smix64.choice(libraries)
echo "PCG likes: " & pcg.choice(libraries)
