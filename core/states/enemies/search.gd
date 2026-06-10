extends State
class_name search


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
#	loading sprite and adding timer for random movement
	enemy.get_node("Sprite2D")
	enemy.timer = 5

func update(delta: float) -> void:
#	logic for determining random movements
#0 = idle, 1 = walk right, -1 = walk left
	enemy.timer-=delta
	if enemy.time<=0:
		enemy.time = randf_range(1,2)
		enemy.choice = randi_range(-1,1)
	enemy.velocity.x = enemy.choice*enemy.s_speed
#	flipping based on movements
	if enemy.velocity.x<0:
		enemy.get_node("Sprite2D").flip_h = 1
		enemy.raycast.target_position = Vector2(-92,0)
	else:
		enemy.get_node("Sprite2D").flip_h = 0
		enemy.raycast.target_position = Vector2(92,0)
	enemy.timer-=delta

	if enemy.raycast.is_colliding():
		var collider = enemy.raycast.get_collider()
		#	checking raycast collisions with main player
		if collider.is_in_group("Mainplayer"):
			enemy.change_state(enemy.a_state)
#	timer to go from alerted (search) state to passive (patrol) state
	if enemy.timer <= 0:
		enemy.change_state(enemy.p_state)
