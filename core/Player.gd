## A Puyo player that keeps track of everything unique to that player
class_name Player
extends Node

# ----------------------------------------
# Static Members, is only read from by this 
# ----------------------------------------

## Rules to be used for all players, set by GameManager
var game_rules: GameRules
## Unique data for the selected character, e.g. dropsets, chant data
var character_data: CharacterData
## Adjustments to the player's gameplay, e.g. drop speed, extra garbage
var handicap_settings

# ----------------------------------------
# Dynamic Members, managed and modified by itself 
# ----------------------------------------

## Generates list of pieces for the queue given rules
var pair_generator : PairGenerator

## The [Playfield] for this player
var playfield : Playfield


func _ready():
	pass
