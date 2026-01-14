extends RigidBody2D


@warning_ignore("unsafe_property_access")
@onready var mat: Material = $Sprite2D.material
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _ready() -> void:
	blink()
	create_tween().tween_method(set_bw, 0.0, 1.0, death_sound.stream.get_length())
	
	if Settings.audio:
		death_sound.volume_linear *= Settings.audio_val
		death_sound.play()


func blink() -> void:
	create_tween().tween_method(set_blink_shader_intensity, 1.0, 0.0, 0.1)

func set_blink_shader_intensity(new_value: float) -> void:
	mat.set_shader_parameter("blink_intensity", new_value)


func set_bw(value: float) -> void:
	mat.set_shader_parameter("bw_amount", value)


func _on_sleeping_state_changed() -> void:
	if sleeping:
		SceneTransitioner.trans_to_scene()
