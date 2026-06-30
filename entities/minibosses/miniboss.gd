extends CharacterBody2D
class_name MiniBoss

@export var current_stage:int = 1
@export var is_invulnerable:bool = false

# locations on this board for boss
@export var top : Vector2 = Vector2(640,100)
@export var left : Vector2 = Vector2(340,300)
@export var right : Vector2 = Vector2(940,300)
@export var base_speed : float = 200.0
@export var base_damage : float = 10.0

@export var target: Vector2 = Vector2.ZERO
@export var is_light_on : bool = false

@onready var health_component = $HealthComponent
@onready var fsm_node = $fsm
@export var active_contact_hitbox: Hitbox

@export var attack_range : float = 70.0 #from suction

func _ready() -> void:
	if health_component:
		health_component.health_changed.connect(_on_health_changed)  #changes states
		health_component.died.connect(_on_boss_died)       
		
	global_position = top
	target = top                                                                                                      
	
	fsm_node.change_state("move")
	
	var body_shape = CircleShape2D.new()
	body_shape.radius = attack_range*0.5
	
	active_contact_hitbox = Hitbox.new(base_damage, 0.0, body_shape, 3)
	
	add_child(active_contact_hitbox)
	


func _on_health_changed(current_health, max_health) -> void:
	if is_invulnerable:
		return
	print("HP is now: ",current_health)
	if current_stage==1 and current_health <= (max_health*0.5):
		current_stage=2
		base_damage *= 1.5
		if active_contact_hitbox:
			active_contact_hitbox.damage = base_damage * 1.5
		fsm_node.change_state("handler")
		
		
	if current_stage==2 and current_health <= (max_health*0.3):
		current_stage=3
		base_damage*=2
		if active_contact_hitbox:
			active_contact_hitbox.damage = base_damage*2
		fsm_node.change_state("handler")
		

func _on_boss_died() -> void:
	queue_free()


func lighting(light_is_on : bool) -> void:
	is_light_on = light_is_on
	
	if is_light_on:
		fsm_node.change_state("stagger")
