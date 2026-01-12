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


func pop() -> void:
	var tween: Tween = create_tween()
	match pop_dir:
		POP_DIRS.UP:
			tween.tween_property(self, "position:y", position.y - Constants.TILE_SIZE, 0.05)
		POP_DIRS.DOWN:
			tween.tween_property(self, "position:y", position.y + Constants.TILE_SIZE, 0.05)
		POP_DIRS.LEFT:
			tween.tween_property(self, "position:x", position.x - Constants.TILE_SIZE, 0.05)
		POP_DIRS.RIGHT:
			tween.tween_property(self, "position:x", position.x + Constants.TILE_SIZE, 0.05)
	pop_sound.play()
