## Class for the player's playfield.
##
## Stores the board data and provides some helper functions for managing and retrieveng data about the board.
@icon("res://core/playfield.svg")
class_name Playfield
extends RefCounted

enum CELL_TYPE {
	VOID=0,
	WALL=-1,
}

## Number of hidden rows above the visible playfield. These rows do not contribute to the chain.
const HIDDEN_ROWS : int = 1

## Struct for a group of puyos
class PuyoGroup:
	## The colour of the group of puyos.
	var color : int
	## The indices of the puyos in the group.
	var puyos: Array[int]
	
	## Add itself to the list of puyos
	func add_puyo(idx: int) -> void:
		puyos.append(idx)

## Struct for a group of [Playfield.PuyoGroup]s
class PuyoGroupCollection:
	## The size of each of the groups in this collection of puyo groups.
	var size: int
	## Array of puyo groups in this collection.
	var groups: Array[PuyoGroup]

# ----------------------------------------
# Dynamic Members, managed and modified by itself 
# ----------------------------------------

## Raw data of the board stored in sequence because Godot doesn't offer typed 2D [Array]s
var data: PackedInt64Array 
## Dimension of the playfield.
var size: Vector2i

# ----------------------------------------
# Functions
# ----------------------------------------

## Convert from index to coordinates. Returns [code]Vector2i(-1, -1)[/code] if the index is invalid.
func get_position_from_index(idx: int) -> Vector2i:
	if idx < 0 or idx > data.size():
		return Vector2i(-1, -1)
	return Vector2i(idx / size.x, idx % size.y)
	
## Convert from coordinates to index. Returns [code]-1[/code] if the position is invalid.
func get_index_from_position(pos: Vector2i) -> int:
	var idx : int = pos.y * size.x + pos.x
	if idx < 0 or idx > data.size():
		return -1
	return idx
	
## Get the puyo colour at the provided coordinates.
func get_color_at_position(pos: Vector2i) -> int:
	# Left and right walls and floor are considered solid.
	if pos.x < 0 or pos.y >= size.x or pos.y >= size.y:
		return CELL_TYPE.WALL
	# Above the ceiling is considered air
	if pos.y < 0:
		return CELL_TYPE.VOID
	# Return data if position is valid
	return data[get_index_from_position(pos)]

## Wrapper for [method Playfield.get_color_at_position] for if the cell is solid.
func get_is_cell_solid_at_position(position: Vector2i) -> bool:
	return get_color_at_position(position) != 0

## Returns an [Array] of [PuyoGroupCollection]s ordered by size. The size of the returned [Array] is that of the largest group of puyos.
func get_groups() -> Array[PuyoGroupCollection]:
	var group_collections = []
	
	# Create a flag array for checking if we've already visited a cell for the floodfill algorithm
	var cell_visited := PackedByteArray()

	# Flood-fill through the board to get the puyo groups.
	
	
	return group_collections

# ----------------------------------------
# Methods
# ----------------------------------------

## Constructor for the [b]Playfield[/b][br]
## Takes in size [param s] and initialises the class.
func _init(s: Vector2i) -> void:
	size = s
	data = PackedInt64Array()
	data.resize(size.x * size.y)

## Manually override board data.
func set_data(d: PackedInt64Array, s: Vector2i = Vector2i(0, 0)) -> void:
	data = d
	if s.x > 0 and s.y > 0:
		size = s

## Flood fill iteration used by [method get_groups]. Should never be called outside that function.
func _flood_fill(cell_visited: PackedByteArray, pos: Vector2i, color: int, group: PuyoGroup) -> void:
	var idx := get_index_from_position(pos)
	if cell_visited[idx]:
		return
	
	var cell_color := get_color_at_position(pos)
	if cell_color != color:
		return
	
	group.add_puyo(idx)
	
	_flood_fill(cell_visited, pos + Vector2i(0, 1), color, group)
	_flood_fill(cell_visited, pos + Vector2i(0, -1), color, group)
	_flood_fill(cell_visited, pos + Vector2i(1, 0), color, group)
	_flood_fill(cell_visited, pos + Vector2i(-1, 0), color, group)
	
	cell_visited[idx] = 1
	
	
#
