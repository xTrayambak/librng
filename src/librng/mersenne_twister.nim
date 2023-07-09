# WARNING: not implemented yet

import generator

type MersenneTwister* = ref object of Generator

proc newMersenneTwister*(seed: int): MersenneTwister =
 MersenneTwister(seed: seed)
