extends CharacterBody2D


const WEIGHT: float = 4.0
const SPEED: float = 600.0
const JUMP_VELOCITY: float = -1500.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * WEIGHT * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var dir: float = Input.get_axis("left", "right")
	if dir:
		velocity.x = SPEED * dir
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
