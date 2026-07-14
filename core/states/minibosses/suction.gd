extends State

@onready var fsm_node : Node = get_parent()
@onready var boss : CharacterBody2D = get_parent().get_parent()

@export var chase_speed : float = 180.0
@export var damage : float = 10.0

#so that boss doesnt swing its weapon all the time
var is_attacking : bool = false
var attack_timer : float = 0.0

func enter() -> void:
	is_attacking = false
	attack_timer = 0.0

func exit() -> void:
	is_attacking = false
	attack_timer = 0.0
	

func update(delta: float) -> void:
	var attack_range = boss.attack_range
	var player = get_tree().get_first_node_in_group("player")
	if not player or not boss:
		return 
	
	if is_attacking:
		attack_timer += delta
		if attack_timer >= 0.6:
			is_attacking = false
			attack_timer = 0.0
			fsm_node.change_state("handler")
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
	attack_timer = 0.0
	boss.velocity = Vector2.ZERO

func mod_speed() -> float:
	if boss.current_stage == 2:
		return chase_speed * 1.5 
		
	elif boss.current_stage == 3:
		return chase_speed * 2.0 
		
	return chase_speed
