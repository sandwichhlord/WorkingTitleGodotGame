extends State

@export var speed : float = 150.0


@onready var fsm_node: Node = get_parent()
@onready var boss: CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	if not boss.is_light_on :
		boss.target = boss.top
		return
		
	_pick_new_target()
	
func exit() -> void:
	boss.velocity = Vector2.ZERO
	
func update(delta: float) -> void:
	if not boss:
		return
	
	var current_speed = mod_speed()
	# updates the global position of the boss
	boss.global_position = boss.global_position.move_toward(
		boss.target,
		current_speed*delta
	)
	
	if boss.global_position.distance_to(boss.target) < 5.0:
		boss.global_position = boss.target
		_arrive_at_point()
		

func _pick_new_target() -> void:
	var points_pool = [boss.top, boss.left, boss.right]
	
	#never picks same point again
	var valid_points = points_pool.filter(func(p): return p.distance_to(boss.global_position) > 10.0)
	
	if valid_points.size() > 0:
		boss.target = valid_points.pick_random()



func _arrive_at_point() -> void:
	if boss.global_position == boss.top and not boss.is_light_on:
		fsm_node.change_state("stagger")
		return
		
	_pick_new_target()
	 #decide_attack()


func mod_speed() -> float:
	if boss.current_stage == 2:
		return speed*1.5
	if boss.current_stage == 3:
		return speed*2
	return speed
	


#func decide_attack() -> void:
#	if boss.current_stage == 1:
#		fsm_node.change_state("venom")
#	if boss.current_stage == 2:
#		fsm_node.change_state("suction")
#	elif boss.current_stage == 3:
#		if randf()>0.5:
#			fsm_node.change_state("venom")
#		else:
#			fsm_node.change_state("suction")
