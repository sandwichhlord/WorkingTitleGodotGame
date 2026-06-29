extends CharacterBody2D
class_name Player

# Movement Variables
@export var max_speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0
var facing_direction: int = 1

# References
@onready var sprite = $Sprite2D
@onready var fsm = $fsm

# Jump/Gravity Variables

@export var jump_velocity: float = -500.0
@export var jump_gravity_multiplier: float = 0.8 # Floaty Jump
@export var fall_gravity_multiplier: float = 2.0 # Heavy Fall
@export var max_jumps: int = 2
@export var coyote_time: float = 0.15 # 150 milliseconds of grace time
@export var jump_buffer_time: float = 0.1

var current_jumps: int = 0

# Dash Variables
@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5
var dash_cooldown_timer: float = 0.0
var can_dash: bool = true


func _ready() -> void:
	pass
	
func _physics_process(delta: float):
	
	var direction = Input.get_axis("move_left","move_right")
	if direction != 0:
		facing_direction = sign(direction)
		sprite.flip_h = (direction < 0)
		
	if not is_on_floor():
		if velocity.y < 0 and Input.is_action_pressed("jump"):
			velocity += get_gravity() * jump_gravity_multiplier * delta
		else:
			velocity += get_gravity() * fall_gravity_multiplier * delta
		
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	else:
		if is_on_floor():
			can_dash = true
	move_and_slide()
