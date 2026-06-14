extends CharacterBody2D


@export var p_speed = 50.0
@export var  ag_speed = 100
@export var  s_speed = 100
@export var  JUMP_VELOCITY = -400.0
var time: float = 0
var timer: float = 0
var choice: int = 0 #0 = idle, 1 = walk right, -1 = walk left
var invincible = false
@onready var raycast = get_node("RayCast2D")
@onready var health = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.died.connect(_on_died)
	health.damage_taken.connect(_on_damage_taken)

func _physics_process(delta):
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_died():
	queue_free()

func _on_damage_taken(amount):
	pass

func _on_hurtbox_body_entered(body: Node2D) -> void:
	print(body.name)
	$HealthComponent.take_damage(10)
