# librng -- RNG for dummies in Nim
librng is a 100% native Nim pseudo-random-number-generation library.

# Why?
`std/random` is an "impure" library (Nim's terminology for libraries that aren't writing their core purpose in Nim)
It also does not support multiple PRNG algorithms, just Xoroshiro128+.
librng is built with adding more algorithms easily in mind. Just add a new type that inherits from `Generator` and implement a `next` function, and you're good to go!

# Installation
```bash
$ nimble install librng
```

# How fast is it?
librng is generally as fast as std/random, sometimes faster. You can try `tests/benchmark.nim` for yourself as the speeds are mostly CPU-dependant.
A small note: librng implements Xoroshiro128 whilst std/random uses Xoroshiro128+ \
All the times are in seconds.
| Iterations | std/random | librng    | Winner     |
| ---------- | ---------- | --------- | ---------- |
| 4          | 2.71       | 0.0001711 | librng     |
| 64         | 4.02       | 0.0001714 | librng     |
| 4096       | 0.00067011 | 0.0037226 | std/random |
| 8192       | 0.00126661 | 0.0060302 | std/random |

# Examples
All examples are in `examples/`