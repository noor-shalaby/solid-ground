extends Area2D
class_name Spike

enum POP_DIRS {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
@export var pop_dir: POP_DIRS = POP_DIRS.UP

@onready var pop_sound: AudioStreamPlayer2D = $PopSound

var property: String
var target_pos: float


func _ready() -> void:
	property = "position:y"
	target_pos = position.y
	if pop_dir == POP_DIRS.RIGHT or pop_dir == POP_DIRS.LEFT:
		property = "position:x"
		target_pos = position.x
	if target_pos == POP_DIRS.UP or POP_DIRS.LEFT:
		target_pos -= 64
	else:
		target_pos += 64


func pop() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, property, target_pos, 0.05)
	pop_sound.play()
