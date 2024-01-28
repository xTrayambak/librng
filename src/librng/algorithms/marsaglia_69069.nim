#[
   CONG is a congruential generator with the widely used 69069
     multiplier: x(n)=69069x(n-1)+1234567. It has period
     2^32. The leading half of its 32 bits seem to pass
     tests, but bits in the last half are too regular.
     The last half of the bits of CONG are too regular,
     and it fails tests for which those bits play a
     significant role. CONG+FIB will also have too much
     regularity in trailing bits, as each does. But keep
     in mind that it is a rare application for which
     the trailing bits play a significant role. CONG
     is one of the most widely used generators of the
     last 30 years, as it was the system generator for
     VAX and was incorporated in several popular
     software packages, all seemingly without complaint.
     (note: this is about the same as Delphi uses)

 This "RNG" algorithm was made by George Marsaglia.
]#
import ../generator

type Marsaglia69069* = ref object of Generator

method next*(m69069: Marsaglia69069): uint64 {.inline.} =
  let res = 69069 * (m69069.seed - 1) + 1234567

  m69069.seed = res

  res

proc newMarsaglia69069*(seed: uint64): Marsaglia69069 =
  Marsaglia69069(seed: seed)
