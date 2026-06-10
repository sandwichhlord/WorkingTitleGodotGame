extends State

var coyote_timer: float = 0.0
var is_coyote_falling: bool = false
var jump_buffer_timer: float = 0.0

func enter():
	# If we have max jumps while falling, it means we walked off a ledge.
	if entity.current_jumps == entity.max_jumps:
		is_coyote_falling = true
		coyote_timer = entity.coyote_time
	else:
		is_coyote_falling = false

func update(delta: float):
	
	var direction = Input.get_axis("move_left","move_right")
	
	if entity.is_on_floor():
		if jump_buffer_timer > 0.0:
			entity.current_jumps = entity.max_jumps
			jump_buffer_timer = 0
			fsm.change_state("Jump")
		else:
			if direction != 0:
				fsm.change_state("Run")
			else:
				fsm.change_state("Idle")
		return
		
	if is_coyote_falling:
		coyote_timer -= delta
		if coyote_timer <= 0.0:
			is_coyote_falling = false
			entity.current_jumps -= 1 # Remove a jump after coyote buffer


	# Jump Input Bufferring
	if jump_buffer_timer > 0: 
		jump_buffer_timer -= delta

	if direction != 0:
		entity.velocity.x = move_toward(entity.velocity.x, direction * entity.max_speed, entity.acceleration * delta)
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, entity.friction * delta)
		
	if Input.is_action_just_pressed("jump"):
		if entity.current_jumps > 0:
			fsm.change_state("Jump")
		else:
			jump_buffer_timer = entity.jump_buffer_time
