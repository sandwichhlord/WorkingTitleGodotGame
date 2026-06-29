extends State

@export var attack_damage: float = 15.0
@export var attack_duration: float = 0.4
@export var target_layer: int = 2

var queued_next_attack: bool = false
@onready var anim_player = owner.get_node("AnimationPlayer")

func enter():
	anim_player.animation_finished.connect(_on_animation_finished)
	queued_next_attack = false
	anim_player.play("swing_2")
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(60, 30)
	var hitbox = Hitbox.new(entity.get_total_damage(attack_damage), attack_duration, shape, target_layer)
	entity.add_child(hitbox)
	hitbox.position.x = 40 * entity.facing_direction

func exit():
	anim_player.animation_finished.disconnect(_on_animation_finished)

func update(_delta: float):
	if Input.is_action_just_pressed("attack"):
		queued_next_attack = true

func _on_animation_finished(anim_name: StringName):
	if anim_name == "swing_2":
		if queued_next_attack:
			fsm.change_state("Attack_3")
		else:
			fsm.change_state("Ready")
