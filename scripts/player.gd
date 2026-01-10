extends CharacterBody2D


const WEIGHT: float = 4.0
const SPEED: float = 600.0
const ACCEL: float = 5000.0
const DECEL: float = 3000.0
const JUMP: float = -1500.0
const JUMP_CUT_MULTIPLYER: float = 0.5
const COYOTE_TIME: float = 0.15

const DEAD_BODY_SCENE: PackedScene = preload("res://scenes/player_dead.tscn")

@onready var parent: Node2D = get_parent()


func _physics_process(delta: float) -> void:
	var coyote_timer: float
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		velocity += get_gravity() * WEIGHT * delta
		coyote_timer -= delta
	
	if Input.is_action_pressed("jump") and coyote_timer > 0:
		velocity.y = JUMP
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT_MULTIPLYER
	
	var dir: float = Input.get_axis("left", "right")
	if dir:
		velocity.x = move_toward(velocity.x, SPEED * dir, ACCEL * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECEL * delta)
	
	move_and_slide()


func die() -> void:
	var dead_body: RigidBody2D = DEAD_BODY_SCENE.instantiate()
	parent.call_deferred("add_child", dead_body)
	dead_body.global_position = global_position
	var bounce_direction: Vector2 = Vector2(randf_range(-2000, 2000), -2000) 
	dead_body.apply_central_impulse(bounce_direction)
	dead_body.angular_velocity = randf_range(-16.0, 16.0)
	queue_free()


func _on_hazard_detector_body_entered(_body: Node2D) -> void:
	die()

func _on_hazard_detector_area_entered(_area: Area2D) -> void:
	die()
