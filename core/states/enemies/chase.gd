extends State
class_name chase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	enemy.get_node("Sprite2D")

func update( delta: float) -> void:
	
	if enemy.raycast.is_colliding():
		var collider = enemy.raycast.get_collider()
#		if player is not in the direct eyesight of the enemy, switch to search state
		if !collider.is_in_group("Mainplayer"):
			fsm.change_state("search")
	else:
		fsm.change_state("search")
	
	if enemy.velocity.x<0:
		enemy.get_node("Sprite2D").flip_h = 1
		enemy.raycast.target_position = Vector2(-92,0)
	else:
		enemy.get_node("Sprite2D").flip_h = 0
		enemy.raycast.target_position = Vector2(92,0)
	enemy.position.x = move_toward(enemy.position.x,player.position.x, enemy.ag_speed*delta)
