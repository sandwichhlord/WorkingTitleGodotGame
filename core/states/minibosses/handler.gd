extends State

@export var duration: float = 1.0

@onready var fsm_node: Node = get_parent()
@onready var boss : CharacterBody2D = get_parent().get_parent()

@export var timer : float = 0.0

func enter() -> void:
	print("Handler entered")
	print("Boss in stage: ",boss.current_stage)
	
	timer = 0.0
	boss.is_invulnerable = true
	boss.velocity = Vector2.ZERO #when state changes it stops
	
	if boss.current_stage == 2:
		boss.get_node("Sprite2D").modulate = Color(2.0, 0.7, 0.7, 1.0)
	elif boss.current_stage == 3:
		boss.get_node("Sprite2D").modulate = Color(3.0, 0.2, 0.2, 1.0)
	
func exit() -> void: 
	boss.is_invulnerable = false

func update(delta: float) -> void: 
	timer += delta
	
	if timer >= duration:
		if boss.current_stage == 1:
			fsm_node.change_state("venom")
		elif boss.current_stage == 2:
			fsm_node.change_state("suction")
			
		elif boss.current_stage == 3:
			if randf() >= 0.5:
				fsm_node.change_state("suction")
			else:
				fsm_node.change_state("venom")
