import librng

echo "Using Xoroshiro128"

var rng = newRNG()

# Generate 32 random numbers between -32 and 32
for n in 0..32:
 echo "#" & $n & ": " & $rng.randint(32)