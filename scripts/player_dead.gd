extends RigidBody2D


@warning_ignore("unsafe_property_access")
@onready var mat: Material = $Sprite2D.material

func _ready() -> void:
	create_tween().tween_method(set_bw, 0.0, 1.0, 0.2)


func set_bw(value: float) -> void:
	mat.set_shader_parameter("bw_amount", value)


func _on_sleeping_state_changed() -> void:
	if sleeping:
		get_tree().call_deferred("reload_current_scene")
