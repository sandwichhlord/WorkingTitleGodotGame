extends State

func update(_delta: float):
	if Input.is_action_just_pressed("attack"):
		fsm.change_state("Attack_1")
	elif Input.is_action_just_pressed("shoot"):
		fsm.change_state("Ranged_Attack")
