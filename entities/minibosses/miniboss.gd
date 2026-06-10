extends CharacterBody2D
class_name MiniBoss

@export var current_stage:int = 1
@export var is_invulnerable:bool = false

@onready var health_component = $HealthComponent
@onready var fsm_node = $fsm

func _ready() -> void:
	if health_component:
		health_component.health_changed.connect(_on_health_changed)  #changes states
		health_component.health_changed.connect(_on_boss_died)       
		

func _on_health_changed(current_health, max_health) -> void:
	if is_invulnerable:
		return
		
	if current_stage==1 and current_health <= (max_health*0.5):
		fsm_node.change_state("Handler")
		
	if current_stage==2 and current_health <= (max_health*0.3):
		fsm_node.change_state("Handler")
		

func _on_boss_died() -> void:
	queue_free()
