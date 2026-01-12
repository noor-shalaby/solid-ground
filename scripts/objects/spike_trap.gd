extends Spike


@export var chase: bool = false
@export var trigger_length: float = 288

const SPEED: float = 1000.0

@onready var pop_trigger: RayCast2D = $PopTrigger
@onready var chase_trigger: RayCast2D = $ChaseTrigger

var is_chasing: bool = false
var player: CharacterBody2D = null


func _ready() -> void:
	super()
	pop_trigger.target_position.y = -trigger_length
	chase_trigger.target_position.y = -trigger_length


func _physics_process(delta: float) -> void:
	if pop_trigger.is_colliding():
		pop()
	
	if not chase:
		return
	if chase_trigger.is_colliding():
		is_chasing = true
		chase_trigger.set_deferred("enabled", false)
	if is_chasing and player:
		if pop_dir == POP_DIRS.UP or pop_dir == POP_DIRS.DOWN:
			position.x = move_toward(position.x, player.position.x, SPEED * delta)
		else:
			position.y = move_toward(position.y, player.position.y, SPEED * delta)


func pop() -> void:
	super()
	player = pop_trigger.get_collider()
	pop_trigger.set_deferred("enabled", false)
