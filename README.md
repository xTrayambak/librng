# librng -- RNG for dummies in Nim
librng is a 100% native Nim pseudo-random-number-generation library, supporting multiple algorithms. \
It has no dependencies other than the Nim standard library (granted, you don't count `nph` as a code formatter) \
You can either individually import an algorithm from the `librng/algorithms` subdirectory, or you can simply import `librng` and use the
`RNG` helper. \
librng supports the C, C++, JS and NimScript* backends.

# RNG Algorithms supported
| Algorithm        | Status         |
| ---------        | ------         |
| Xoroshiro128     | Yes            |
| LCG              | Yes            |
| Splitmix64       | Yes            |
| Mersenne Twister | Yes            |
| Marsaglia 69069  | Yes            |
| Lehmer64         | Yes            |
| Xoroshiro128**   | Yes            |
| Xoroshiro128++   | Yes            |
| PCG              | Yes            |
| ChaCha20         | No             |

# Installation
You can install librng straight from Nimble.
```bash
$ nimble install librng
```

# Examples
All examples are in `examples/`. They should give you an idea of how to use the library.

# Contributing
Make sure to write unit tests if you're adding a new algorithm. This allows us to integrate it easily into the GitHub Actions tests.
Please run the `nimble format` task to run `nph` before submitting your contributions. Thanks :)
