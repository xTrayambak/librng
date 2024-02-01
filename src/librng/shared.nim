proc rotl*(x, k: uint64): uint64 {.inline.} =
  (x shl k) or (x shr (64'u64 - k))
