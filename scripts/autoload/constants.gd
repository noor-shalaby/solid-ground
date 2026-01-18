extends Node


const TILE_SIZE: int = 64
const PITCH_SHIFTING: float = 0.1

const SAVE_PATH: String = "user://"

const FILE_UIDS: Dictionary[String, Variant] = {
	# SCENES
		# objects
	"player_dead_body_scene": "uid://dw52c6e8h77rj",
		# vfx
	"dust_puff_scene": "uid://dsw4ruvwbym5k",
		# sounds
	"hurt_sounds": [
		"uid://kb1n1pubyf6i",
		"uid://c84sd8ewyhire",
		"uid://cuiui84ksbuhw",
		"uid://6uvvxjuhngy"
	],
	"click_sound_scene": "uid://dbjd5elpu7hmv",
	"back_sound_scene": "uid://c7pynfib6cqwl"
}


func _ready() -> void:
	randomize()
