extends State
class_name search_troll


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
#	loading sprite and adding timer for random movement
	entity.get_node("Sprite2D")
	entity.timer = 5

func update(delta: float) -> void:
#	logic for determining random movements
#0 = idle, 1 = walk right, -1 = walk left
	
	entity.timer-=delta
	if entity.time<=0:
		entity.time = randf_range(1,2)
		entity.choice = randi_range(-1,1)
	entity.velocity.x = entity.choice*entity.s_speed
#	flipping based on movements
	if entity.velocity.x<0:
		entity.get_node("Sprite2D").flip_h = 1
		entity.raycast.target_position = Vector2(-92,0)
	else:
		entity.get_node("Sprite2D").flip_h = 0
		entity.raycast.target_position = Vector2(92,0)
	entity.time-=delta

	if entity.raycast.is_colliding():
		var collider = entity.raycast.get_collider()
		#	checking raycast collisions with main player
		if collider.is_in_group("Mainplayer"):
			fsm.change_state("chase")
#	timer to go from alerted (search) state to passive (patrol) state
	if entity.timer <= 0:
		fsm.change_state("patrol")
		
func exit():
	entity.velocity.x = 0
