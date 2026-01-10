extends Control


@onready var viewport: Viewport = get_viewport()
@onready var play_button: Buttona = %PlayButton


func _input(event: InputEvent) -> void:
	if viewport.gui_get_focus_owner():
		return
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_focus_next"):
		play_button.grab_focus()
