extends Buttona


func _on_pressed() -> void:
	super()
	
	# Reload scene
	SceneTransitioner.trans_to_scene()
