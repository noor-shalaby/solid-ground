extends CharacterBody2D


const WEIGHT: float = 4.0
const SPEED: float = 600.0
const ACCEL: float = 5000.0
const DECEL: float = 3000.0
const JUMP: float = -1500.0
const JUMP_CUT_MULTIPLYER: float = 0.5


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * WEIGHT * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT_MULTIPLYER
	
	var dir: float = Input.get_axis("left", "right")
	if dir:
		velocity.x = move_toward(velocity.x, SPEED * dir, ACCEL * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECEL * delta)
	
	move_and_slide()
