extends RigidBody2D


@warning_ignore("unsafe_property_access")
@onready var mat: Material = $Sprite2D.material
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _ready() -> void:
	create_tween().tween_method(set_bw, 0.0, 1.0, death_sound.stream.get_length())
	death_sound.play()


func set_bw(value: float) -> void:
	mat.set_shader_parameter("bw_amount", value)


func _on_sleeping_state_changed() -> void:
	if sleeping:
		SceneTransitioner.trans_to_scene()
