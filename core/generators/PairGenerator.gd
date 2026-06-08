## Generator for upcoming Puyo pairs given the game rules.
## 
@icon("res://core/class_icons/pair_generator.svg")
class_name PairGenerator
extends RefCounted

## Index for order of pair shapes.
enum PAIR_SHAPE {
	PAIR, L, J, SWIRL, BIG
}

# ----------------------------------------
# Static Members, is only read from by this 
# ----------------------------------------

# Flag for whether to use custom dropset or basic Tsu dropset.
# var is_tsu_rules : bool

## The character's dropset for Fever style modes.
var dropset : Array[ActivePuyo.SHAPE]

## Length of dropset array
var dropset_length : int

## Order of colors the generated puyo pairs will use.
var color_order : PackedByteArray

# ----------------------------------------
# Dynamic Members, managed and modified by this class
# ----------------------------------------

## Index of the current color for pair generation.
var color_index : int = 0

## Index of the current pair shape 
var shape_index : int = 0

# ----------------------------------------
# Methods
# ----------------------------------------



## Gets the next color from the array, with consideration of the first 4 colors using a special pool
func get_next_color() -> int:
	var next_color := color_order[color_index]
	color_index = (color_index + 1) % color_order.size()
	return next_color

## Generate a new puyo using provided data
func generate_next_puyo() -> ActivePuyo:
	var new_puyo := ActivePuyo.new()
	var puyo_shape := dropset[shape_index]
	new_puyo.puyo_shape = puyo_shape
	shape_index = (shape_index + 1) % dropset_length
	
	var main_color := get_next_color()
	# Bottom left corner puyo is always present
	new_puyo.puyo_colours.append(main_color)
	new_puyo.puyo_offsets.append(Vector2i(0, 0))
	# Add puyo data
	match puyo_shape:
		PAIR_SHAPE.PAIR:
			new_puyo.puyo_colours.append(get_next_color())
			new_puyo.puyo_offsets.append(Vector2i(0, -1))
		PAIR_SHAPE.L:
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(0, -1))
			new_puyo.puyo_colours.append(get_next_color())
			new_puyo.puyo_offsets.append(Vector2i(1, 0))
		PAIR_SHAPE.L:
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(1, 0))
			new_puyo.puyo_colours.append(get_next_color())
			new_puyo.puyo_offsets.append(Vector2i(0, -1))
		PAIR_SHAPE.SWIRL:
			var next_color := get_next_color()
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(0, -1))
			new_puyo.puyo_colours.append(next_color)
			new_puyo.puyo_offsets.append(Vector2i(1, 0))
			new_puyo.puyo_colours.append(next_color)
			new_puyo.puyo_offsets.append(Vector2i(1, -1))
		PAIR_SHAPE.BIG:
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(0, -1))
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(1, 0))
			new_puyo.puyo_colours.append(main_color)
			new_puyo.puyo_offsets.append(Vector2i(1, -1))
	
	return new_puyo


# 
