extends State

@onready var fsm_node : Node = get_parent()
@onready var boss: CharacterBody2D = get_parent().get_parent()

@export var duration : float = 4.0

func enter() -> void:
	boss.velocity=Vector2.ZERO
	
	await get_tree().create_timer(duration).timeout
	_recover()
	
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	

func _recover() -> void:
	fsm_node.change_state("move")
