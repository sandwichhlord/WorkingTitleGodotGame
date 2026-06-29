extends State

@export var attack_damage: float = 10.0
@export var attack_duration: float = 0.3
@export var target_layer: int = 2

var queued_next_attack: bool = false
@onready var anim_player = owner.get_node("AnimationPlayer")

func enter():
	queued_next_attack = false
	anim_player.play("swing_1")
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(40, 40)
	var hitbox = Hitbox.new(entity.get_total_damage(attack_damage), attack_duration, shape, target_layer)
	
	entity.add_child(hitbox)
	hitbox.position.x = 30 * entity.facing_direction

func update(_delta: float):
	if Input.is_action_just_pressed("attack"):
		queued_next_attack = true
		

func _on_animation_finished():
	if queued_next_attack:
		fsm.change_state("Attack_2")
	else:
		fsm.change_state("Ready")
