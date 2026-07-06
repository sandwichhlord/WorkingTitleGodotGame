extends State
class_name attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	entity.get_node("Sprite2D")

func update(delta: float) -> void:
#	add attacking function 
	if entity.raycast.is_colliding():
		var collider = entity.raycast.get_collider()
		if collider.is_in_group("Mainplayer"):
			entity.change_state(entity.s_state)
	else:
		entity.change_state(entity.s_state)
	
	if entity.velocity.x<0:
		entity.get_node("Sprite2D").flip_h = 1
		entity.raycast.target_position = Vector2(-92,0)
	else:
		entity.get_node("Sprite2D").flip_h = 0
		entity.raycast.target_position = Vector2(92,0)
	#entity.position = entity.position.move_toward(entity.m_entity.position, entity.ag_speed*delta)
