extends State

func update(delta: float):
	
	var direction = Input.get_axis("move_left","move_right")
	
	if entity.is_on_floor():
		if direction != 0:
			fsm.change_state("Run")
		else:
			fsm.change_state("Idle")
		return
	
	if direction != 0:
		entity.velocity.x = move_toward(entity.velocity.x, direction * entity.max_speed, entity.acceleration * delta)
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, entity.friction * delta)
		
	if Input.is_action_just_pressed("jump") and entity.current_jumps > 0:
		fsm.change_state("Jump")
