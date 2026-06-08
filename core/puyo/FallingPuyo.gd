## Class for free-falling puyos.
##
## [b]FallingPuyo[/b] is the class for Puyos that fall from gravity after either from chains removing support for Puyos above or from [ActivePuyo]s being split off a ledge.
@icon("res://core/class_icons/falling_puyo.svg")
class_name FallingPuyo
extends Puyo

## Starting velocity of falling puyos in sub-pixels per frame.
const STARTING_VELOCITY : int = SUBPIXEL_COUNT / 16
## Gravity of falling puyos in sub-pixels per frame^2. Value is from Tsu.
const GRAVITY : int = SUBPIXEL_COUNT * 0x3000 / 0xffff / 16
## Max speed the puyo can fall at in sub-pixels per frame.
const TERMINAL_VELOCITY : int = SUBPIXEL_COUNT / 2


# ----------------------------------------
# Static Members, is set at creation and only read from
# ----------------------------------------

## Color of the falling puyo
var color : int

# ----------------------------------------
# Dynamic Members, managed and modified by this class
# ----------------------------------------

## Current speed the puyo falls at. Default starting speed is 1/16th of a cell
var velocity : int = STARTING_VELOCITY
## Frames to wait until it can start falling for [class ActivePuyo]s. Replicates Tsu behaviour.
var fall_delay_timer : int = 0
## Flag for if the puyo has landed 

# ----------------------------------------
# Functions
# ----------------------------------------

# ----------------------------------------
# Methods
# ----------------------------------------

## Falls the puyos from gravity.[br]
## @experimental: TODO
## [b]Note:[/b] [url=https://puyonexus.com/wiki/Puyo_Puyo_Tsu/Frame_Data_Tables#Free_fall_speed]Puyo Nexus[/url] claims that terminal velocity is reached in 31 in "about" 31 frames from rounding errors(?), yet [url=https://puyonexus.com/wiki/Puyo_Puyo_Tsu/Free_fall]on another page[/url] it states the expected 39 frames.[br]
## This implementation follows the 38 frame version which is [i]probably[/i] the correct one.[br]
## Additionally, there should actually be a 1 frame delay for landing but that extra frame is moved to the actual placement routine.
func fall_puyo():
	# Active puyos take a few frames before they start falling, slave puyos for some reason 1 frame longer.
	if fall_delay_timer > 0:
		fall_delay_timer -= 1
		return
	
	position.y += velocity
	
	# Gravity is applied after velocity in Tsu 
	velocity += GRAVITY
	
