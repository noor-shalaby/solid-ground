extends Buttona


func _on_pressed() -> void:
	# Scale up and then back down slowly
	pop_animation()
	
	# Play click or back sound
	if sfx and Settings.audio:
		if button_pressed:
			AudioManager.play_oneshot(AudioManager.CLICK_SOUND_SCENE)
		else:
			AudioManager.play_oneshot(AudioManager.BACK_SOUND_SCENE)
