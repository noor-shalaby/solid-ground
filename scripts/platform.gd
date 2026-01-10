extends AnimatableBody2D


@export var spike_trigger: int = 2

@onready var spike_trap: Area2D = $SpikeTrap


func _on_player_detector_body_entered(_body: CharacterBody2D) -> void:
	spike_trigger -= 1
	if spike_trigger <= 0:
		spike_trap.pop()
