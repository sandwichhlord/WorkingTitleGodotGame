extends State
class_name Attack_troll
# Called when the node enters the scene tree for the first time.
var direction_player
@export var attack_cooldown: float = 2
var a_cooldown= 0
@export var attack_duration: float = 1.5
var a_duration = 1.5
@export var a_damage = 10
@export var shape: Shape2D
@export var target_mask: int
var player: CharacterBody2D
var hitbox: Area2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Mainplayer")
	shape.size = Vector2(45,55)

func update(delta):
	direction_player = sign(player.global_position.x - entity.global_position.x)
	if entity.global_position.distance_to(player.global_position) > entity.attack_radius:
		fsm.change_state("chase")
	
	if a_duration>0:
		a_duration-=delta
		return
	if a_cooldown>0:
		a_cooldown-=delta
		return

	if a_cooldown<=0:
		a_cooldown = attack_cooldown
		a_duration = attack_duration
		hitbox = Hitbox.new(a_damage, attack_duration,shape, target_mask)
		hitbox.position = Vector2(direction_player*40, 0)
		entity.add_child(hitbox)
	
	
	#if a_cooldown<=0:
		#a_cooldown = attack_cooldown
		#hitbox = Hitbox.new(a_damage, attack_duration,shape, target_mask)
		#entity.add_child(hitbox)
	#else:
		#a_duration -= delta
	
