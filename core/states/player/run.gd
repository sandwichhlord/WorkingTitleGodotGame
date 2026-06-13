extends State

func enter():
	entity.current_jumps = entity.max_jumps

func update(delta: float):
	if not entity.is_on_floor():
		fsm.change_state("Fall")
		return
	
	var direction = Input.get_axis("move_left","move_right")
	
	if direction != 0:
		entity.velocity.x = move_toward(entity.velocity.x, direction * entity.max_speed, entity.acceleration * delta)
	else:
		fsm.change_state("Idle")
		
	if Input.is_action_just_pressed("jump"):
		fsm.change_state("Jump")
		
	if Input.is_action_just_pressed("dash") and entity.can_dash: 
		fsm.change_state("Dash")	
