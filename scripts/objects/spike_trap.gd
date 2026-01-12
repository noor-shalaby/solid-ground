extends Spike


@export_range(0.0, 30.0, 1.0, "suffix:tiles") var trigger_length: float = 1
@export var chase: bool = false
@export var chase_limit_up: int
@export var chase_limit_down: int
@export var chase_limit_left: int
@export var chase_limit_right: int

const SPEED: float = 1000.0

@onready var scene_tree: SceneTree = get_tree()
@onready var sprites: Array[Node] = $Sprites.get_children()
var width: float = 128
@onready var pop_trigger: RayCast2D = $PopTrigger

var is_chasing: bool = false
var player: CharacterBody2D = null


func _ready() -> void:
	pop_trigger.target_position.y = -trigger_length * Constants.TILE_SIZE
	width = 0
	for sprite in sprites:
		@warning_ignore("unsafe_property_access")
		width += sprite.texture.get_width()


func _physics_process(delta: float) -> void:
	if pop_trigger.is_colliding():
		pop()
	
	if is_chasing and player:
		if pop_dir == POP_DIRS.UP or pop_dir == POP_DIRS.DOWN:
			if chase_limit_left:
				position.x = max(position.x, chase_limit_left + (width/2 + SPEED * delta))
			elif chase_limit_right:
				position.x = min(position.x, chase_limit_right - (width/2 + SPEED * delta))
			position.x = move_toward(position.x, player.position.x, SPEED * delta)
		else:
			if chase_limit_up:
				position.x = max(position.x, chase_limit_up + (width/2 + SPEED * delta))
			elif chase_limit_down:
				position.x = min(position.x, chase_limit_down - (width/2 + SPEED * delta))
			position.y = move_toward(position.y, player.position.y, SPEED * delta)


func pop() -> void:
	super()
	
	player = pop_trigger.get_collider()
	pop_trigger.set_deferred("enabled", false)
	if chase:
		await scene_tree.create_timer(0.2).timeout
		is_chasing = true
