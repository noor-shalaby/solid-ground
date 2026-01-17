extends Area2D
class_name Spike

enum POP_DIRS {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
@export var pop_dir: POP_DIRS = POP_DIRS.UP

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var pop_sound: AudioStreamPlayer2D = $PopSound
@onready var pop_sound_default_vol: float = pop_sound.volume_linear


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
	
	anim_player.play("pop")
	CamCtrl.screenshake(16, 0.08)
	
	if Settings.audio:
		pop_sound.volume_linear = pop_sound_default_vol * Settings.audio_val
		pop_sound.pitch_scale = randf_range(1.0 - Constants.PITCH_SHIFTING, 1.0 + Constants.PITCH_SHIFTING)
		pop_sound.play()
