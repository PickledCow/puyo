## Base class for puyos with physics.
## 
## Abstract base class for Puyos that move (that is, not static on the board).
@icon("res://core/puyo/icons/puyo.svg")
class_name Puyo
extends RefCounted

## Subpixels per grid space
const SUBPIXEL_COUNT : int = 2**16

## Integer position of the puyo on the board. Rounds numerically down / physically up on the grid.
var position : Vector2i
## Subpixel y-position of the puyo from [0, 255].
var y_subpixel : int = 0

# ----------------------------------------
# Functions
# ----------------------------------------

## Returns the subpixel of the puyo
func get_subpixel() -> int:
	return y_subpixel
	
## Returns the position of the puyo. Not to be confused with get_puyo_positions for ActivePuyo
func get_position() -> Vector2i:
	return position
