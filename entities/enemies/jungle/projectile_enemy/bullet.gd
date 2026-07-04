extends CharacterBody2D

var hitbox: Hitbox
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var spawn_position = global_position
var initialpos: Vector2

func _ready():
	initialpos = position


func create_hitbox(damage: float, lifetime: float, shape: Shape2D, target_mask: int):
	hitbox = Hitbox.new(damage, lifetime, shape, target_mask)
	add_child(hitbox)

func remove_hitbox():
	if hitbox:
		hitbox.queue_free()
		hitbox = null

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
