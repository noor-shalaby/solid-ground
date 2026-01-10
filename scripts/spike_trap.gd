extends Spike


@export var chase: bool = false

const SPEED: float = 1000.0

@onready var pop_trigger: RayCast2D = $PopTrigger
@onready var chase_trigger: RayCast2D = $ChaseTrigger

var is_chasing: bool = false
var player: CharacterBody2D = null


func _ready() -> void:
	chase_trigger.enabled = chase


func _physics_process(delta: float) -> void:
	if pop_trigger.is_colliding():
		pop()
	
	if not chase:
		return
	if chase_trigger.is_colliding():
		is_chasing = true
		chase_trigger.set_deferred("enabled", false)
	if is_chasing and player:
		position.x = move_toward(position.x, player.position.x, SPEED * delta)


func pop() -> void:
	super()
	player = pop_trigger.get_collider()
	pop_trigger.set_deferred("enabled", false)
