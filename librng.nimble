# Package

version       = "0.1.3"
author        = "xTrayambak"
description   = "A collection of PRNG algorithms written in Nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.12"
taskRequires "format", "nph >= 0.3.0"

task format, "Format code using nph":
  exec "nph src/"
  exec "nph examples/"
  exec "nph tests/"
