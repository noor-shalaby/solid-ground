extends Node


const CLICK_SOUND_SCENE: PackedScene = preload("uid://dbjd5elpu7hmv")
const BACK_SOUND_SCENE: PackedScene = preload("uid://c7pynfib6cqwl")

var ambient_fade_out: float = 0.3

@onready var scene_tree: SceneTree = get_tree()


func play_oneshot(sfx: PackedScene = CLICK_SOUND_SCENE) -> void:
	var oneshot_sfx: AudioStreamPlayer = sfx.instantiate()
	add_child(oneshot_sfx)
