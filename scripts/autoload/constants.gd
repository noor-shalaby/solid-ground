extends Node


const TILE_SIZE: int = 64

const SAVE_PATH: String = "user://"

const FILE_UIDS: Dictionary[String, Variant] = {
	# SCENES
		# objects
	"player_dead_body_scene": "uid://dw52c6e8h77rj",
		# sounds
	"click_sound_scene": "uid://dbjd5elpu7hmv",
	"back_sound_scene": "uid://c7pynfib6cqwl"
}


func _ready() -> void:
	randomize()
