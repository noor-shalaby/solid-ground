extends Node2D


func _ready() -> void:
	for particle: CPUParticles2D in get_children():
		particle.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
