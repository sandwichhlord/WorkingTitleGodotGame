extends State

func update(delta: float):
	if not owner.is_on_floor():
		fsm.change_state("Fall")
		return
	
	var direction = Input.get_axis("move_left","move_right")
	
	if direction != 0:
		owner.velocity.x = move_toward(owner.velocity.x, direction * owner.max_speed, owner.acceleration * delta)
	else:
		fsm.change_state("Idle")
	
