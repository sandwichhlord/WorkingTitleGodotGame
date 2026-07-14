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
@export var hitbox_lifetime: float = 0.0
@export var shape: Shape2D = RectangleShape2D.new()
@export var target_mask: int = 1
@export var damage: float = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.died.connect(_on_died)
	health.damage_taken.connect(_on_damage_taken)
	shape.size = Vector2(55, 50)
	var hitbox = Hitbox.new(
	10,
	0.0,
	shape,
	1
)
	add_child(hitbox)
	

func _physics_process(delta):
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
	#if hitbox == null:
		#var hitbox = Hitbox.new(
	#10,
	#1.0,
	#shape,
	#1)

func _on_died():
	queue_free()

func _on_damage_taken(amount):
	pass

func _on_hurtbox_body_entered(body: Node2D) -> void:
	print(body.name)
	$HealthComponent.take_damage(10)
