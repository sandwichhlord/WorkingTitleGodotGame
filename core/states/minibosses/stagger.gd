extends State

@onready var fsm_node : Node = get_parent()
@onready var boss: CharacterBody2D = get_parent().get_parent()

@export var duration : float = 8.0
@export var timer : float = 0.0
@export var suck_speed : float = 300.0

@export var light_coordinate : Vector2 = Vector2(640,100)
@export var reached_light : bool = false


func enter() -> void:
	reached_light = false
	timer = 0.0
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	if not reached_light:
		var distance = boss.global_position.distance_to(light_coordinate)
		
		if distance <= 10.0:
			boss.global_position = light_coordinate
			boss.velocity = Vector2.ZERO
			reached_light = true
			
		else :
			var direction = boss.global_position.direction_to(light_coordinate)
			boss.velocity = suck_speed*direction
			boss.move_and_slide()
	else:
		boss.velocity=Vector2.ZERO
		timer+=delta
		if timer >= duration:
			_recover()

func _recover() -> void:
	if "is_light_on" in boss:
		boss.is_light_on = false
		
	if boss.current_stage == 1:
		fsm_node.change_state("move")
	elif boss.current_stage >= 2:
		fsm_node.change_state("handler")
