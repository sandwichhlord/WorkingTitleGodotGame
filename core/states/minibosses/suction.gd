extends State

@onready var fsm_node : Node = get_parent()
@onready var boss : CharacterBody2D = get_parent().get_parent()

@export var chase_speed : float = 180.0
@export var attack_range : float = 70.0
@export var damage : float = 10.0

#so that boss doesnt swing its weapon all the time
var is_attacking : bool = false

func enter() -> void:
	is_attacking = false
	

func exit() -> void:
	pass
	

func update(delta: float) -> void:
	#if we are attacking ignore
	if is_attacking:
		return
		
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return 
	
	if not boss:
		return
		
	var current_speed = mod_speed()
	
	var direction = boss.global_position.direction_to(player.global_position)
	var desired_vel = direction*current_speed
	
	#we use lerp(linear interpolation) so that it overshoots a bit depending on the bias
	var bias = 2.5
	boss.velocity = boss.velocity.lerp(desired_vel,bias*delta)
	boss.move_and_slide()
	
	if boss.global_position.distance_to(player.global_position) <= attack_range:
		_attack(direction)

func _attack(attack_dir:Vector2) -> void:
	is_attacking = true
	boss.velocity = Vector2.ZERO
	
	await get_tree().create_timer(0.6).timeout
	
	is_attacking = false


func mod_speed() -> float:
	if boss.current_stage == 2:
		return chase_speed * 1.5 
		
	elif boss.current_stage == 3:
		return chase_speed * 2.0 
		
	return chase_speed
