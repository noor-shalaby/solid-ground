extends CharacterBody2D


const WEIGHT: float = 4.0
const SPEED: float = 600.0
const ACCEL: float = 5000.0
const DECEL: float = 3000.0
const JUMP: float = -1500.0
const JUMP_CUT_MULTIPLYER: float = 0.5
const COYOTE_TIME: float = 0.15

const DEATH_MAX_IMPULSE: float = 2000.0
var death_bounce_impulse: Vector2 = Vector2(randf_range(-DEATH_MAX_IMPULSE, DEATH_MAX_IMPULSE), -DEATH_MAX_IMPULSE)

const DEAD_BODY_SCENE: PackedScene = preload(Constants.FILE_UIDS.player_dead_body_scene)

@onready var parent: Node2D = get_parent()
@onready var hazard_detector: Area2D = $HazardDetector
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var land_sound: AudioStreamPlayer2D = $LandSound


func _physics_process(delta: float) -> void:
	var coyote_timer: float
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		velocity += get_gravity() * WEIGHT * delta
		coyote_timer -= delta
	
	if Input.is_action_pressed("jump") and coyote_timer > 0:
		velocity.y = JUMP
		jump_sound.play()
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
	dead_body.apply_central_impulse(death_bounce_impulse)
	dead_body.angular_velocity = randf_range(-16.0, 16.0)
	queue_free()


func _on_hazard_detector_body_entered(_body: Node2D) -> void:
	die()

func _on_hazard_detector_area_entered(_area: Area2D) -> void:
	if _area is Spike:
		@warning_ignore("unsafe_property_access")
		match _area.pop_dir:
			@warning_ignore("unsafe_property_access")
			_area.POP_DIRS.UP:
				death_bounce_impulse = Vector2(randf_range(-DEATH_MAX_IMPULSE/2, DEATH_MAX_IMPULSE/2), -DEATH_MAX_IMPULSE)
			@warning_ignore("unsafe_property_access")
			_area.POP_DIRS.DOWN:
				death_bounce_impulse = Vector2(randf_range(-DEATH_MAX_IMPULSE/2, DEATH_MAX_IMPULSE/2), DEATH_MAX_IMPULSE)
			@warning_ignore("unsafe_property_access")
			_area.POP_DIRS.LEFT:
				death_bounce_impulse = Vector2(-DEATH_MAX_IMPULSE, randf_range(0, DEATH_MAX_IMPULSE/2))
			@warning_ignore("unsafe_property_access")
			_area.POP_DIRS.RIGHT:
				death_bounce_impulse = Vector2(DEATH_MAX_IMPULSE, randf_range(0, DEATH_MAX_IMPULSE/2))
	die()
