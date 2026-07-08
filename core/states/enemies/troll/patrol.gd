extends State
class_name patrol_troll

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


func enter():
	entity.get_node("Sprite2D")
	
func update( delta: float) -> void:
	#	logic for determining random movements
	#0 = idle, 1 = walk right, -1 = walk left
	
	if entity.time<=0:
		entity.time = randf_range(1,2)
		entity.choice = randi_range(-1,1)
	entity.velocity.x = entity.choice*entity.p_speed
#	flipping
	if entity.velocity.x<0:
		entity.get_node("Sprite2D").flip_h = 1
		entity.raycast.target_position = Vector2(-92,0)
		entity.get_node("hurtbox").position.x = -abs(entity.get_node("hurtbox").position.x)
	else:
		entity.get_node("Sprite2D").flip_h = 0
		entity.raycast.target_position = Vector2(92,0)
		entity.get_node("hurtbox").position.x = abs(entity.get_node("hurtbox").position.x)
	entity.time-=delta
	if entity.raycast.is_colliding():
		var collider = entity.raycast.get_collider()
#		checking main player collision
		if collider.is_in_group("Mainplayer"):
			fsm.change_state("chase")
	
func exit():
	entity.velocity.x = 0
