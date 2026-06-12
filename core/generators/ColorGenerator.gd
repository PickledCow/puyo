## Generator for upcoming puyo colors given the game rules.
## 
@icon("res://core/class_icons/color_generator.svg")
class_name ColorGenerator
extends RefCounted

## How many colours are in the bag that gets shuffled.
const COLOR_BAG_SIZE : int = 256

## Minimum amount of colours you can play with
const MIN_COLOR : int = 3

## Maximum amount of colours you can play with
const MAX_COLOR : int = 5

## Number of the first [code]n[/code] colours in all queues to replace with from the [code]3[/code] dropset.[br]
## Tsu default has first 4 colours be from the [code]3[/code] pool. 
const INIT_COLOR_REPLACEMENT_COUNT : int = 4

		
## Stores the colour pools of size [constant COLOR_BAG_SIZE] for each amount of colours played with from [constant MIN_COLOR] to [constant MAX_COLOR].
var pools : Array[PackedByteArray]

## The [RNG20th] used for colour generation.
var rng : RNG20th


## Implementation of the shuffle function from 20th.
func shuffle_pool(pool: PackedByteArray) -> void:
	for l in 3:
		var length := (0x10 << l)
		var n_rows := 0x100 / length
		for row in n_rows - 1:
			for n_swaps in length >> 1:
				var i1 := row * length + rng.rand_mod(length)
				var i2 := row * length + rng.rand_mod(length)
				var temp := pool[i1]
				pool[i1] = pool[i2]
				pool[i2] = temp

## Gets a copy of the current colour pool by index.
func get_color_pool(idx: int) -> PackedByteArray:
	return pools[idx].duplicate()

## Creates and shuffles the colour pools.
func generate_pools(game_seed: int) -> void:
	rng.set_seed(game_seed)
	# First fill pools with even colour distribution, e.g. 1, 2, 3, 1, 2, 3, etc.[br]
	# Lowest colour is [code]1[/code] as [code]0[/code] is the value for an empty cell.
	for i in MAX_COLOR - MIN_COLOR + 1:
		var color_count := i + MIN_COLOR
		var pool := pools[i]
		for c in COLOR_BAG_SIZE:
			pool[c] = c % color_count + 1
	
	# Then shuffle each pool
	for pool in pools:
		shuffle_pool(pool)
	
	# Finally, get the first INIT_COLOR_REPLACEMENT_COUNT puyos from the first pool and distribute it to the rest.
	for i in MAX_COLOR - MIN_COLOR:
		var pool := pools[i+1]
		for color_idx in INIT_COLOR_REPLACEMENT_COUNT:
			pool[color_idx] = pools[0][color_idx]
	
func _init() -> void:
	rng = RNG20th.new()
	
	# Init pools
	pools = []
	for i in MAX_COLOR - MIN_COLOR + 1:
		var pool := PackedByteArray()
		pool.resize(COLOR_BAG_SIZE)
		pools.append(pool)
	
