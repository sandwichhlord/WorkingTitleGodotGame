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
@onready var camera = $Camera2D

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

# Camera Variables

@export var default_zoom: Vector2 = Vector2(1, 1) 
@export var map_zoom: Vector2 = Vector2(0.2, 0.2)     
@export var look_vertical_distance: float = 300.0    
@export var time_before_camera_center: float = 1.5 
@export var target_offset_x: float = 550.0
@export var camera_lerp_smoothening: float = 1.5

var camera_idle_timer: float = 0.0
var current_target_zoom = default_zoom
var target_offset_y = 0.0

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
	camera_process(delta)

func camera_process(delta): 
	
#	if Input.is_action_pressed("map"):
#		current_target_zoom = map_zoom
#	else:
#		current_target_zoom = default_zoom

	if is_on_floor() and abs(velocity.x) == 0:
		if Input.is_action_pressed("look_up"):
			target_offset_y = -look_vertical_distance
		elif Input.is_action_pressed("look_down"):
			target_offset_y = look_vertical_distance
		else:
			target_offset_y = 0.0
	else:
		target_offset_y = 0.0 

	camera.zoom = camera.zoom.lerp(current_target_zoom, camera_lerp_smoothening * delta)
	camera.offset.y = lerp(camera.offset.y, target_offset_y, camera_lerp_smoothening * delta)
	
	if abs(velocity.x) > 0:
		camera_idle_timer = 0.0
		camera.offset.x = lerp(camera.offset.x, target_offset_x * facing_direction, camera_lerp_smoothening * delta)
	else:
		camera_idle_timer += delta 
		if camera_idle_timer >= time_before_camera_center:
			camera.offset.x = lerp(camera.offset.x, 0.0, camera_lerp_smoothening * delta)
	
