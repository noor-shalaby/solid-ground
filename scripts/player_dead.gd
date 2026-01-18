extends RigidBody2D


const HURT_SOUNDS: Array[AudioStreamWAV] = [
	preload(Constants.FILE_UIDS.hurt_sounds[0]),
	preload(Constants.FILE_UIDS.hurt_sounds[1]),
	preload(Constants.FILE_UIDS.hurt_sounds[2]),
	preload(Constants.FILE_UIDS.hurt_sounds[3])
]

@warning_ignore("unsafe_property_access")
@onready var mat: Material = $Sprite2D.material
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound


func _ready() -> void:
	# Shader VFX
	blink()
	create_tween().tween_method(set_bw, 0.0, 1.0, death_sound.stream.get_length())
	
	# Hurt SFX
	if Settings.audio:
		hurt_sound.stream = HURT_SOUNDS.pick_random()
		hurt_sound.volume_linear *= Settings.audio_val
		hurt_sound.pitch_scale = randf_range(1.0 - Constants.PITCH_SHIFTING, 1.0 + Constants.PITCH_SHIFTING)
		hurt_sound.play()
	
	# Time Stop & Camera Zoom Effect
	Engine.time_scale = 0.1
	CamCtrl.cam.zoom = Vector2(1.05, 1.05)
	await get_tree().create_timer(0.2, true, false, true).timeout
	Engine.time_scale = 1.0
	CamCtrl.cam.zoom = Vector2.ONE
	
	# Death SFX
	if Settings.audio:
		death_sound.volume_linear *= Settings.audio_val
		death_sound.play()


func blink() -> void:
	create_tween().tween_method(set_blink_shader_intensity, 1.0, 0.0, 0.1)

func set_blink_shader_intensity(new_value: float) -> void:
	mat.set_shader_parameter("blink_intensity", new_value)


func set_bw(value: float) -> void:
	mat.set_shader_parameter("bw_amount", value)


# Restart level when the body stops moving
func _on_sleeping_state_changed() -> void:
	if sleeping:
		SceneTransitioner.trans_to_scene()
