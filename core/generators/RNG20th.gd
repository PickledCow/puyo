## Implementation of the RNG function from 20th.
@icon("res://core/class_icons/rng_20th.svg")
class_name RNG20th
extends RefCounted

## Flag for if the initial seed should be limited to 16-bits like with the official games.
const LIMIT_STARTING_SEED : bool = true

## The current seed of the RNG.
var game_seed: int

## Sets the initial seed, limited to a 16-bit number if [constant LIMIT_STARTING_SEED] is set to [code]true[/code].
func set_seed(s: int) -> void:
	game_seed = s
	## ?????
	if LIMIT_STARTING_SEED:
		game_seed &= 0xFFFF

## Generate a random number with optional modulo. If [param modulo] is non-zero, the output is limited to 16-bit instead of 32-bit because SEGA.
func rand_mod(modulo: int = 0) -> int:
	game_seed = (game_seed * 0x5D58_8B65 + 0x0026_9EC3) & 0xFFFF_FFFF
	var result := game_seed >> 0x10
	if modulo:
		## Limit to 16-bit output?????
		result = (result * modulo) >> 0x10
	return result
