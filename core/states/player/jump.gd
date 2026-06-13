extends State

func enter():
	entity.velocity.y = entity.jump_velocity
	entity.current_jumps -= 1
	
func update(delta: float):
	
	var direction = Input.get_axis("move_left","move_right")
	
	if entity.velocity.y >= 0:
		fsm.change_state("Fall")
		return
	
	if direction != 0:
		entity.velocity.x = move_toward(entity.velocity.x, direction * entity.max_speed, entity.acceleration * delta)
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, entity.friction * delta)
		
	if Input.is_action_just_pressed("jump") and entity.current_jumps > 0:
		fsm.change_state("Jump")
		
	if Input.is_action_just_pressed("dash") and entity.can_dash: 
		fsm.change_state("Dash")	
