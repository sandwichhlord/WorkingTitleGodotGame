extends State

@export var duration: float = 1.0

@onready var fsm_node: Node = get_parent()
@onready var boss : CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	boss.current_stage += 1
	print("Boss in stage: ",boss.current_stage)
	
	boss.is_invulnerable = true
	boss.velocity = Vector2.ZERO #when state changes it stops
	
	if boss.current_stage == 2:
		boss.get_node("Sprite2D").modulate = Color(2.0, 0.7, 0.7, 1.0)
	elif boss.current_stage == 3:
		boss.get_node("Sprite2D").modulate = Color(3.0, 0.2, 0.2, 1.0)
		
	await get_tree().create_timer(duration).timeout
	boss.is_invulnerable = false
	
	if boss.current_stage == 3:
		fsm_node.change_state("suction")
	else :
		fsm_node.change_state("move")
	
func exit() -> void: pass

func update(delta: float) -> void: 
	pass
