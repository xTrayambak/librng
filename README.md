# librng -- RNG for dummies in Nim
librng is a 100% native Nim pseudo-random-number-generation library, supporting multiple algorithms. \
It has no dependencies other than the Nim standard library (granted, you don't count `nph` as a code formatter) \
You can either individually import an algorithm from the `librng/algorithms` subdirectory, or you can simply import `librng` and use the
`RNG` helper. \
librng supports the C, C++, JS and NimScript* backends.

# RNG Algorithms supported
| Algorithm        | Status         |
| ---------        | ------         |
| Xoroshiro128     | yes            |
| LCG              | yes            |
| Splitmix64       | yes            |
| Mersenne Twister | yes            |
| Marsaglia 69069  | yes            |
| Lehmer64         | yes            |
| Xoroshiro128++   | no             |
| ChaCha20         | no             |
| PCG              | no             |

# Installation
You can install librng straight from Nimble.
```bash
$ nimble install librng
```

# Contributing
Please run the `nimble format` task to run `nph` before submitting your contributions. Thanks :)

# Examples
All examples are in `examples/`
