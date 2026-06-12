extends CharacterBody2D
class_name MiniBoss

@export var current_stage:int = 1
@export var is_invulnerable:bool = false

# locations on this board for boss
@export var top : Vector2 = Vector2(640,100)
@export var left : Vector2 = Vector2(340,300)
@export var right : Vector2 = Vector2(940,300)
@export var speed : float = 200.0

@export var target: Vector2 = Vector2.ZERO
@export var is_light_on : bool = true

@onready var health_component = $HealthComponent
@onready var fsm_node = $fsm

func _ready() -> void:
	if health_component:
		health_component.health_changed.connect(_on_health_changed)  #changes states
		health_component.health_changed.connect(_on_boss_died)       
		
	global_position = top
	target = top
	
	fsm_node.change_state("move")

func _on_health_changed(current_health, max_health) -> void:
	if is_invulnerable:
		return
		
	if current_stage==1 and current_health <= (max_health*0.5):
		fsm_node.change_state("Handler")
		
	if current_stage==2 and current_health <= (max_health*0.3):
		fsm_node.change_state("Handler")
		

func _on_boss_died(current_health, max_health) -> void:
	if current_health <= 0:
		queue_free()


func lighting(light_is_on : bool) -> void:
	is_light_on = light_is_on
	
	if not is_light_on:
		target = top
		fsm_node.change_state("move")
