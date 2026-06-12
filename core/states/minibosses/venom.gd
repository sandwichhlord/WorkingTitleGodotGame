extends State

@onready var fsm_node: Node = get_parent()
@onready var boss: CharacterBody2D = get_parent().get_parent()

@onready var pool : Node = boss.get_node_or_null("ProjectilePool")


func enter() -> void:
	boss.velocity = Vector2.ZERO
	
	await get_tree().create_timer(0.2).timeout
	
	_shoot()
	
	await get_tree().create_timer(0.2).timeout
	
	fsm_node.change_state("move")
	
func exit() -> void:
	pass
	
func update(delta:float) -> void:
	pass
	

func _shoot() -> void:
	if not pool:
		print("pool not defined")
		return
		
	var base_dir = Vector2.DOWN #fallback direction
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		base_dir = boss.global_position.direction_to(player.global_position)
		
	var spread_angle = deg_to_rad(15)

	var dir_left = base_dir.rotated(-spread_angle)
	var dir_center = base_dir
	var dir_right = base_dir.rotated(spread_angle)
	
	print("boss is shooting")
	
	pool.spawn(boss.global_position,dir_left)
	pool.spawn(boss.global_position,dir_center)
	pool.spawn(boss.global_position,dir_right)
	
