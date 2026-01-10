extends Area2D
class_name Spike


func pop() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position:y", position.y - 64, 0.05)
