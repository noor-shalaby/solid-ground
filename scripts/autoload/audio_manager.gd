extends Node


const CLICK_SOUND_SCENE: PackedScene = preload(Constants.FILE_UIDS.click_sound_scene)
const BACK_SOUND_SCENE: PackedScene = preload(Constants.FILE_UIDS.back_sound_scene)

var music_fade_out: float = 0.3

@onready var scene_tree: SceneTree = get_tree()
@onready var music_player: AudioStreamPlayer = $Music
@onready var music_default_volume_linear: float = music_player.volume_linear


func play_music() -> void:
	if not Settings.audio or not Settings.music or music_player.playing:
		return
	
	music_player.volume_linear = music_default_volume_linear * Settings.audio_val * Settings.music_val
	music_player.play()

func stop_music() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(music_player, "volume_linear", 0.0, music_fade_out)
	await tween.finished
	music_player.stop()


func play_oneshot(sfx: PackedScene = CLICK_SOUND_SCENE) -> void:
	if not Settings.audio:
		return
	
	var oneshot_sfx: AudioStreamPlayer = sfx.instantiate()
	add_child(oneshot_sfx)
