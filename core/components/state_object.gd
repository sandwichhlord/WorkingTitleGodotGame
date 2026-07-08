extends Area2D

@export var max_hit : int = 1
@export var current_hit : int

@onready var before_sprite = $BeforeState
@onready var after_sprite = $AfterState
@onready var collision = $CollisionShape2D

func _ready() -> void:
	current_hit = max_hit
	after_sprite.visible = false
	before_sprite.visible = true
	


func recieve_hit(damage: float, attacker : Node2D) -> void:
	if attacker and attacker.is_in_group("player"):
		current_hit-=1
		if current_hit<=0:
			state_change()
		

func state_change() -> void:
	before_sprite.visible = false
	after_sprite.visible = true
	collision.set_deferred("disabled",true)
	
