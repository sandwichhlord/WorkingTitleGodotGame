extends State
class_name chase

var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func enter():
	entity.get_node("Sprite2D")
	player = get_tree().get_first_node_in_group("Mainplayer")
	
func update( delta: float) -> void:
	
	if entity.raycast.is_colliding():
		var collider = entity.raycast.get_collider()
#		if player is not in the direct eyesight of the entity, switch to search state
		if !collider.is_in_group("Mainplayer"):
			fsm.change_state("search")
	else:
		fsm.change_state("search")
	
	if entity.velocity.x<0:
		entity.get_node("Sprite2D").flip_h = 1
		entity.raycast.target_position = Vector2(-92,0)
	else:
		entity.get_node("Sprite2D").flip_h = 0
		entity.raycast.target_position = Vector2(92,0)
	entity.position.x = move_toward(entity.position.x,player.position.x, entity.ag_speed*delta)
