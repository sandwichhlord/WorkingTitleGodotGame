extends State

@export var speed : float = 180.0
@export var height : float = 250.0
@export var attack_interval : float = 2


@onready var fsm_node: Node = get_parent()
@onready var boss: CharacterBody2D = get_parent().get_parent()

var attack_timer : float = 0.0

func enter() -> void:
	attack_timer = 0.0;
	var start_speed = mod_speed()        #variable speed as if changes per stage
	boss.velocity = Vector2(-start_speed,0)     #moves towards left at first 
	
func exit() -> void:
	boss.velocity = Vector2.ZERO
	
func update(delta: float) -> void:
	if not boss:
		return
	
	boss.global_position.y = height
	
	if boss.is_on_wall():
		var wall_normal = boss.get_wall_normal()    #wall normal tells the perpendicular direction and reverses it
		boss.velocity.x = wall_normal.x * mod_speed()
		
	else:
		var cur = sign(boss.velocity.x)
		boss.velocity.x = cur* mod_speed()
		
	boss.move_and_slide()
	
	attack_timer += delta
	if attack_timer >= curr_interval():        #cinterval which would help us change the speed of attacks 
		attack_timer = 0.0
		decide_attack()
	
		
func curr_interval() -> float :
	if boss.current_stage == 3:
		return 0.5 * attack_interval
	else:
		return attack_interval



func mod_speed() -> float:
	if boss.current_stage == 2:
		return speed*1.5
	if boss.current_stage == 3:
		return speed*2
	return speed
	


func decide_attack() -> void:
	if boss.current_stage == 1:
		fsm.change_state("venom")
	if boss.current_stage == 2:
		fsm.change_state("suction")
	elif boss.current_stage == 3:
		if randf()>0.5:
			fsm.change_state("venom")
		else:
			fsm.change_state("suction")
