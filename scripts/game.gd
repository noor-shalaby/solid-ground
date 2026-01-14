extends Node2D


func _ready() -> void:
	if Settings.gameplay_mouse_capture:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
