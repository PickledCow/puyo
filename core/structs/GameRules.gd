## Rules shared between players for the match
@icon("res://core/class_icons/game_rules.svg")
class_name GameRules
extends RefCounted

## Natural drop speed of the active piece in subpixels per frame. Default takes 16 frames to pass 1 cell.
var drop_speed : int = Puyo.SUBPIXEL_COUNT / 16

## Soft drop speed of the active piece in subpixels per frame. Default takes 2 frames to pass 1 cell.
var soft_drop_speed : int = Puyo.SUBPIXEL_COUNT / 2

## Are players allowed to instantly place puyos.
var is_hard_drop_enabled : bool = false

## If the UI should have "fun" movement (bouncy and jiggly).
var is_fun_enabled : bool = true
