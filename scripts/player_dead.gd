extends RigidBody2D


func _on_sleeping_state_changed() -> void:
	if sleeping:
		get_tree().call_deferred("reload_current_scene")
