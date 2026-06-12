## Rules unique to each player.
@icon("res://core/class_icons/player_handicap.svg")
class_name PlayerHandicap
extends RefCounted

## How many colours the player will play with. Different colour counts play with different pools.
var color_count : int = 4

## Speed at which [ActivePuyo] will fall at in sub-pixels per frame. By default it takes 16 frames to move 1 cell.
var drop_speed : int = Puyo.SUBPIXEL_COUNT / 16

## How many rows of garbage the player has to start the match with.
var starting_garbage_rows : int = 0
