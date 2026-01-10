extends CanvasLayer


@export var animation_duration_pause: float = 0.2
@export var animation_duration_unpause: float = 0.3
@export var screen_transition_duration: float = 0.2
@export var tween_trans: Tween.TransitionType
@export var tween_ease: Tween.EaseType

@onready var scene_tree: SceneTree = get_tree()
@onready var viewport: Viewport = get_viewport()
@onready var viewport_visible_rect: Rect2 = viewport.get_visible_rect()
@onready var dim: PanelContainer = $Dim
@onready var resume_button: Buttona = %ResumeButton

var tween: Tween


func _ready() -> void:
	hide()
	dim.modulate.a = 0.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not scene_tree.paused:
			pause()
		else:
			unpause()
	
	if viewport.gui_get_focus_owner() or not scene_tree.paused:
		return
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_focus_next"):
		resume_button.grab_focus()


func pause() -> void:
	AudioManager.play_oneshot()
	
	show()
	refresh_tween()
	tween.tween_property(dim, "modulate:a", 1.0, (1.0 - dim.modulate.a) * animation_duration_pause)
	
	resume_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	scene_tree.paused = true

func unpause() -> void:
	AudioManager.play_oneshot(AudioManager.BACK_SOUND_SCENE)
	
	if viewport.gui_get_focus_owner():
		viewport.gui_get_focus_owner().release_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	refresh_tween()
	tween.tween_property(dim, "modulate:a", 0.0, dim.modulate.a * animation_duration_unpause)
	await tween.finished
	hide()
	
	scene_tree.paused = false

func refresh_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

func _on_resume_button_pressed() -> void:
	unpause()
