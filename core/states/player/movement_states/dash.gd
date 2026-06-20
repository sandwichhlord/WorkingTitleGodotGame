extends State

var dash_timer: float = 0.0
var dash_direction: int = 1

func enter():
	dash_direction = entity.facing_direction
	entity.velocity.y = 0
	entity.velocity.x = dash_direction * entity.dash_speed
	dash_timer = entity.dash_duration
	entity.can_dash = false
	entity.dash_cooldown_timer = entity.dash_cooldown

func update(delta: float):
	if entity.is_movement_locked: return
	dash_timer-=delta
	if dash_timer <= 0.0:
		if entity.is_on_floor():
			if Input.get_axis("move_left", "move_right") != 0:
				fsm.change_state("Run")
			else:
				fsm.change_state("Idle")
		else:
			fsm.change_state("Fall")
		return
		
	entity.velocity.y = 0
	entity.velocity.x = dash_direction * entity.dash_speed
