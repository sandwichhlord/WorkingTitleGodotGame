extends State

@export var attack_damage: float = 30.0
@export var attack_duration: float = 0.6
@export var target_layer: int = 2

@onready var anim_player = owner.get_node("AnimationPlayer")

func enter():
	entity.is_movement_locked = true
	anim_player.play("swing_3")
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(101, 60)
	var hitbox = Hitbox.new(entity.get_total_damage(attack_damage), attack_duration, shape, target_layer)
	entity.add_child(hitbox)
	hitbox.position.x = 50 * entity.facing_direction

func exit():
	entity.is_movement_locked = false

func update(_delta: float):
	pass

func _on_animation_finished():
	fsm.change_state("Ready")
