extends Area2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.DOWN
@export var lifetime: float = 2.0 # Deactivates after 2 seconds to save the pool

var creator: Node = null
var current_damage: float = 10.0
var alive_time: float = 0.0

func _ready() -> void:
	# Listens for Hurtboxes instead of solid walls
	area_entered.connect(_on_area_entered)

# Added the damage parameter here
func setup_projectile(spawn_dir: Vector2, spawn_creator: Node, damage: float = 10.0) -> void:
	direction = spawn_dir.normalized()
	creator = spawn_creator
	current_damage = damage
	alive_time = 0.0 # Reset the timer every time it leaves the pool

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	
	# The Failsafe: if it misses and flies forever, return it to the pool
	alive_time += delta
	if alive_time >= lifetime:
		_deactivate()

func _on_area_entered(area: Area2D) -> void:
	# Don't let the boss/player shoot themselves
	if area.owner == creator:
		return
		
	# The handshake with your HurtboxComponent
	if area.has_method("recieve_hit"):
		area.recieve_hit(current_damage)
		
	# Disappear after hitting the target
	_deactivate()

# Helper function so we don't have to write these two lines repeatedly
func _deactivate() -> void:
	visible = false
	process_mode = PROCESS_MODE_DISABLED
