## Class for active puyo object.
##
## [b]ActivePuyo[/b] is the pair of Puyos that the player controls while it falls.[br]
@icon("res://core/class_icons/active_puyo.svg")
class_name ActivePuyo
extends Puyo

## Index for order of pair shapes.
enum SHAPE {
	PAIR, L, J, SWIRL, BIG, QUARTET
}

## Frame time it takes to rotate a piece.
const ROTATION_ANIMATION_TIME : int = 8
## Frame time it takes to move a piece laterally.
const MOVE_ANIMATION_TIME : int = 8
## Frame window for double rotation.
const DOUBLE_ROTATION_WINDOW : int = 40
## Frame time it takes for a piece to lock automatically.
const GROUND_LOCK_TIME : int = 32
## Number of times the piece can cross the midpoint before force locking to prevent indefinite stalling.
const MID_POINT_CROSS_MAX_COUNT : int = 8
## Frame that the master puyo waits before actually falling. Replicates Tsu behaviour.
const MASTER_PUYO_FREE_FALL_DELAY : int = 1
## Frame that the slave puyos waits before actually falling. Replicates Tsu behaviour.
const SLAVE_PUYO_FREE_FALL_DELAY : int = 2

# ----------------------------------------
# Static Members, is set at creation and only read from
# ----------------------------------------

## Shape of puyo for rendering.
var puyo_shape : SHAPE
## Offsets of the individual puyos.
var puyo_offsets : Array[Vector2i] = []
## Colours of the individual puyos.
var puyo_colours : Array[int] = []
## Flag for if this is a big puyo. Used for custom rotation behaviour (cycle through colors instead).
var is_big_puyo : bool = false

# ----------------------------------------
# Dynamic Members, managed and modified by this class
# ----------------------------------------

## Timer for puyo pair to rotate visually.
var rotation_animation_timer : int = 0
## Timer for puyo pair to move laterally visually.
var move_animation_timer : int = 0
## Dynamic relative position of all puyo segments.
var puyo_positions : Array[Vector2i] = []
## Timer for how long the puyo can be grounded for.
var ground_lock_timer : int = GROUND_LOCK_TIME
## Counter for how many grid cell midpoints the piece has crossed.
var mid_point_cross_count : int = 0
## Flag for if the puyo is hard dropped
var is_hard_dropped : bool = false

# ----------------------------------------
# Function
# ----------------------------------------

## Returns the positions of the current puyo segments as a copy for safety.
func get_puyo_positions() -> Array[Vector2i]:
	return puyo_positions.duplicate()


# ----------------------------------------
# Methods
# ----------------------------------------

## Rotate puyo piece or puyo colours for big types.[br]
## [param clockwise]: Direction of rotation. [br]
## [param rotation_amount]: 1: Single rotation, 2: Double rotation (pair puyo only).
func rotate_piece(clockwise: bool, rotation_amount : int = 1) -> void:
	if clockwise:
		print(rotation_amount)
	#var rotation_direction := 1 if clockwise else 0
	#var rotated := 0 # 0: Not rotated, 1: Rotated 90 degrees, 2: Rotated 180 degrees
	pass
	#match puyo_shape:
		#SHAPE.PAIR:
			#pass
		#

## Fall the piece by provided speed in subpixels. [br]
## Increments [member midpoint_cross_count] if it crosses the midpoint of a cell. [br]
## Fall speed is restricted to [lb]0, [constant SUBPIXEL_COUNT][rb] to keep logic sane; [ActivePuyo]s may not move more than 1 tile per frame or fall upwards.
func fall_piece(fall_speed: int) -> void:
	var prev_y_subpixel := y_subpixel
	# Fall at requested speed
	y_subpixel += clamp(fall_speed, 0, SUBPIXEL_COUNT)
	
	# Increment midpoint_cross_count when we cross
	if prev_y_subpixel < SUBPIXEL_COUNT / 2 and y_subpixel >= SUBPIXEL_COUNT / 2:
		mid_point_cross_count += 1
	
	# Advance to next cell when necessary
	if y_subpixel >= SUBPIXEL_COUNT:
		y_subpixel -= SUBPIXEL_COUNT
		position.y += 1

## Landing procedure for the active puyo. Call this method if the active puyo is on a surface. [br]
## Returns true if the piece should lock.
func land_piece(down_held: bool = false) -> bool:
	y_subpixel = 0
	ground_lock_timer += 1
	return ground_lock_timer > GROUND_LOCK_TIME or mid_point_cross_count >= MID_POINT_CROSS_MAX_COUNT or down_held
	

## Returns an Array of [FallingPuyo]s that should replace itself. [br]
## This method [b]does not[/b] clear itself!
func create_falling_puyos() -> Array[FallingPuyo]:
	var falling_puyos : Array[FallingPuyo] = []
	for i in len(puyo_colours):
		var falling_puyo := FallingPuyo.new()
		falling_puyos.append(falling_puyo)
		
		falling_puyo.color = puyo_colours[i]
		falling_puyo.position = position + puyo_positions[i]
		# Oh silly Tsu
		falling_puyo.fall_delay_timer = MASTER_PUYO_FREE_FALL_DELAY if i == 0 else SLAVE_PUYO_FREE_FALL_DELAY
		if is_hard_dropped:
			falling_puyo.velocity = FallingPuyo.TERMINAL_VELOCITY
	
	return falling_puyos



# 
