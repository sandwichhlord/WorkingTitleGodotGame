extends State
class_name attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	enemy.get_node("Sprite2D")

func update(delta: float) -> void:
#	add attacking function 
	if enemy.raycast.is_colliding():
		var collider = enemy.raycast.get_collider()
		if collider.is_in_group("Mainplayer"):
			enemy.change_state(enemy.s_state)
	else:
		enemy.change_state(enemy.s_state)
	
	if enemy.velocity.x<0:
		enemy.get_node("Sprite2D").flip_h = 1
		enemy.raycast.target_position = Vector2(-92,0)
	else:
		enemy.get_node("Sprite2D").flip_h = 0
		enemy.raycast.target_position = Vector2(92,0)
	#enemy.position = enemy.position.move_toward(enemy.m_enemy.position, enemy.ag_speed*delta)
