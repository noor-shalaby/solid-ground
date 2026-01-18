extends CanvasLayer


@export var fade_in_duration: float = 0.1
@export var fade_out_duration: float = 0.2

@onready var scene_tree: SceneTree = get_tree()
@onready var scene_root: Node = $/root
@onready var dim: ColorRect = $Dim
@onready var trans_sound: AudioStreamPlayer2D = $TransSound
@onready var trans_sound_default_vol: float = trans_sound.volume_linear

var tween: Tween

func _ready() -> void:
	fade_out()


func trans_to_scene(scene_path: String = "") -> void:
	# Pause the current scene
	scene_tree.paused = true
	
	# Play the scene transition sound
	if Settings.audio:
		trans_sound.volume_linear = trans_sound_default_vol * Settings.audio_val
		trans_sound.play()
	
	# Show and fade the screen into black
	show()
	reset_tween()
	tween.tween_property(dim, "color:a", 1.0, fade_in_duration)
	await tween.finished
	
	# Change or reload scene
	if scene_path:
		scene_tree.change_scene_to_file(scene_path)
	else:
		scene_tree.reload_current_scene()
	
	# Disable the camera if the scene is a UI screen and enable it otherwise
	if scene_tree.current_scene is Control:
		CamCtrl.disable()
	else:
		CamCtrl.enable()
	
	# Wait till the new scene has loaded and then fade out to reveal it
	await scene_root.child_entered_tree
	fade_out()


func quit() -> void:
	# Pause the current scene
	scene_tree.paused = true
	
	# Show and fade the screen into black
	show()
	reset_tween()
	tween.tween_property(dim, "color:a", 1.0, fade_in_duration)
	await tween.finished
	
	# Quit the game entirely
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
