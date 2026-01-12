extends Spike


@export var chase: bool = false
@export_range(0.0, 30.0, 1.0, "suffix:tiles") var trigger_length: float = 1

const SPEED: float = 1000.0

@onready var scene_tree: SceneTree = get_tree()
@onready var pop_trigger: RayCast2D = $PopTrigger

var is_chasing: bool = false
var player: CharacterBody2D = null


func _ready() -> void:
	pop_trigger.target_position.y = -trigger_length * Constants.TILE_SIZE


func _physics_process(delta: float) -> void:
	if pop_trigger.is_colliding():
		pop()
	
	if is_chasing and player:
		if pop_dir == POP_DIRS.UP or pop_dir == POP_DIRS.DOWN:
			position.x = move_toward(position.x, player.position.x, SPEED * delta)
		else:
			position.y = move_toward(position.y, player.position.y, SPEED * delta)


func pop() -> void:
	super()
	player = pop_trigger.get_collider()
	pop_trigger.set_deferred("enabled", false)
	if chase:
		await scene_tree.create_timer(0.2).timeout
		is_chasing = true
