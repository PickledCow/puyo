## Renderer for the [Playfield], [ActivePuyo], and upcoming queue puyos.
## @experimental
##
## Draws fully filling its bounding box, stretching if necessary. As such, [member size] should ideally be set to an even division of the visible board with respect to the puyo sprites.
@icon("res://core/class_icons/puyo_renderer.svg")
class_name PuyoRenderer
extends Control

## Dimension of puyo board in puyos.
var board_size : Vector2i

## Number of rows above the visible column.
var hidden_rows : int

## Size of each puyo being rendered in pixels.
var puyo_size : Vector2

## Update [member board_size] and [member hidden_rows] and derived variables ([member puyo_size]).
## @experimental
func update_board_size(s: Vector2i, h: int) -> void:
	board_size = s
	hidden_rows = h
	
	puyo_size = size / Vector2(board_size.x, board_size.y - hidden_rows)


## Draw the current active puyo.
## @experimental
func draw_active_puyo(active_puyo: ActivePuyo) -> void:
	pass


## Draw puyo in queue.
## @experimental
func draw_next_puyo(next_puyo: ActivePuyo) -> void:
	pass


## Draw the current playfield.
## @experimental
func draw_playfield(board: PackedInt64Array) -> void:
	pass
