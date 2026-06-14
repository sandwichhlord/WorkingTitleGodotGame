extends State
class_name patrol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


func enter():
	enemy.get_node("Sprite2D")
	
func update( delta: float) -> void:
	#	logic for determining random movements
	#0 = idle, 1 = walk right, -1 = walk left
	
	if enemy.time<=0:
		enemy.time = randf_range(1,2)
		enemy.choice = randi_range(-1,1)
	enemy.velocity.x = enemy.choice*enemy.p_speed
#	flipping
	if enemy.velocity.x<0:
		enemy.get_node("Sprite2D").flip_h = 1
		enemy.raycast.target_position = Vector2(-92,0)
		enemy.get_node("hurtbox").position.x = -abs(enemy.get_node("hurtbox").position.x)
	else:
		enemy.get_node("Sprite2D").flip_h = 0
		enemy.raycast.target_position = Vector2(92,0)
		enemy.get_node("hurtbox").position.x = abs(enemy.get_node("hurtbox").position.x)
	enemy.time-=delta
	if enemy.raycast.is_colliding():
		var collider = enemy.raycast.get_collider()
#		checking main player collision
		if collider.is_in_group("Mainplayer"):
			fsm.change_state("chase")
	
