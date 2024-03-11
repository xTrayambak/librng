proc rotl*(x, k: uint64): uint64 {.inline.} =
  (x shl k) or (x shr (64'u64 - k))

proc rotr*(x, k: uint64): uint64 {.inline.} =
  (x shr k) or (x shl (64'u64 - k))

proc U64FromU32*(src1, src2: uint32): uint64 {.inline.} =
  let 
    x = cast[uint64](src1)
    y = cast[uint64](src2)

  (y shl 32) or x
