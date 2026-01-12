extends AnimatableBody2D


@export var is_trap: bool = false
@export var spike_trigger: int = 1

@onready var spike: Area2D = $Spike
@onready var player_detector: Area2D = $PlayerDetector


func _ready() -> void:
	player_detector.monitoring = is_trap


func _on_player_detector_body_entered(_body: CharacterBody2D) -> void:
	spike_trigger -= 1
	if spike_trigger <= 0:
		spike.pop()
