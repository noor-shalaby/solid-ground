extends Node2D


var host: CharacterBody2D

var shake_intensity: float = 0.0
var active_shake_dur: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise: FastNoiseLite = FastNoiseLite.new()

@onready var cam: Camera2D = $Camera
@onready var viewport_rect: Rect2 = get_viewport_rect()


func _ready() -> void:
	position = get_viewport().get_visible_rect().size / 2
	disable()


func _process(delta: float) -> void:
	# Follow the player
	if host:
		global_position = host.global_position
	
	if not Settings.screenshake:
		return
	
	# Screenshake
	if active_shake_dur > 0.0:
		shake_time += shake_time_speed * delta
		active_shake_dur -= delta
		
		cam.offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		cam.offset = lerp(cam.offset, Vector2.ZERO, 10.5 * delta)


func enable() -> void:
	cam.enabled = true
	cam.make_current()

func disable() -> void:
	cam.enabled = false


func screenshake(intensity: int, dur: float) -> void:
	if not Settings.screenshake:
		return
	
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity * Settings.screenshake_val
	active_shake_dur = dur * max(Settings.screenshake_val / 2.0, 2.4)
	shake_time = 0.0
