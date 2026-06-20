extends State

func update(_delta: float):
	if Input.is_action_just_pressed("attack"):
		fsm.change_state("Attack_1")
