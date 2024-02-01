# Package

version       = "0.1.2"
author        = "xTrayambak"
description   = "A collection of PRNG algorithms written in Nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.12"
requires "nph >= 0.3.0"

task format, "Format code using nph":
  exec "nph src/"
  exec "nph examples/"
  exec "nph tests/"
