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
| Iterations | std/random | librng    |
| ---------- | ---------- | --------- |
| 4          | 1.93       | 0.0001129 |
| 64         | 7.61       | 0.0003347 |
| 4096       | 0.00046455 | 0.0039513 |
| 8888888    | 0.79794369 | 0.6654346 |

# Examples
All examples are in `examples/`