extends Buttona


@export var target_scene_path: String


func _on_pressed() -> void:
	super()
	
	# Change scene
	if target_scene_path:
		SceneTransitioner.trans_to_scene(target_scene_path)
