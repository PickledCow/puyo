## Settings unique to the character
@icon("res://core/class_icons/character_data.svg")
class_name CharacterData
extends RefCounted

## Index for Chants
enum CHANT {
	CHAIN_1,
	CHAIN_2,
	CHAIN_3,
	CHAIN_4,
	REPEATER,
	COUNTER,
	SPELL_1,
	SPELL_2,
	SPELL_3,
	SPELL_4,
	SPELL_5,
	DAMAGE_L,
	DAMAGE_H,
}


## Custom order of chants in Tsu gameplay
var tsu_chant_order : Array[CHANT] = [
	CHANT.CHAIN_1, CHANT.CHAIN_2, CHANT.SPELL_1, CHANT.SPELL_2, CHANT.SPELL_3, CHANT.SPELL_4, CHANT.SPELL_5
]

## Paths to the sfx file for the character's chants
var chant_samples : Array[String]

## Order of dropset
