extends State

func enter():
	entity.current_jumps = entity.max_jumps

func update(delta: float):
	if not entity.is_on_floor():
		fsm.change_state("Fall")
		return
		
	entity.velocity.x = move_toward(entity.velocity.x, 0, entity.friction * delta)
	
	if Input.get_axis("move_left", "move_right") != 0:
		fsm.change_state("Run")
	if Input.is_action_just_pressed("jump"):
		fsm.change_state("Jump")
