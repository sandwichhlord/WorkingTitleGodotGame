extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var detection: Area2D
@export var x_speed: int
@export var shape: Shape2D
@onready var Detection = get_node("Detection_Area");
@onready var bullet = get_node("bullet");

func _ready(): 
	var hitbox = Hitbox.new(
	10,
	0.0,
	shape,
	1
	)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
