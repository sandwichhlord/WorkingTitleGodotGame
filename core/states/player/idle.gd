extends State

func update(delta: float):
	if not owner.is_on_floor():
		fsm.change_state("Fall")
		return
		
	owner.velocity.x = move_toward(owner.velocity.x, 0, owner.friction * delta)
	
	if Input.get_axis("move_left", "move_right") != 0:
		fsm.change_state("Run")
