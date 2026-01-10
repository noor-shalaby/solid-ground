extends CanvasLayer


@export var fade_in_duration: float = 0.1
@export var fade_out_duration: float = 0.2

@onready var scene_tree: SceneTree = get_tree()
@onready var scene_root: Node = $/root
@onready var dim: ColorRect = $Dim
@onready var tran_sound: AudioStreamPlayer2D = $TransSound

var tween: Tween

func _ready() -> void:
	fade_out()


func trans_to_scene(scene_path: String = "") -> void:
	scene_tree.paused = true
	tran_sound.play()
	
	show()
	reset_tween()
	tween.tween_property(dim, "color:a", 1.0, fade_in_duration)
	await tween.finished
	
	if scene_path:
		scene_tree.change_scene_to_file(scene_path)
	else:
		scene_tree.reload_current_scene()
	
	await scene_root.child_entered_tree
	fade_out()


func quit() -> void:
	scene_tree.paused = true
	
	show()
	reset_tween()
	tween.tween_property(dim, "color:a", 1.0, fade_in_duration)
	await tween.finished
	
	scene_tree.quit()


func fade_out() -> void:
	reset_tween()
	tween.tween_property(dim, "color:a", 0.0, fade_out_duration)
	await tween.finished
	
	hide()
	scene_tree.paused = false


func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
