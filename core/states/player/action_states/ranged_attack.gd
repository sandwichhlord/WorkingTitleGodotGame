extends State

@export var shoot_damage: float = 10.0

@onready var pool = owner.get_node("ProjectilePool")
@onready var gun = owner.get_node("Visuals/GunPosition")

@onready var anim_player = owner.get_node("AnimationPlayer")

var queued_shoot: bool = false

func enter():
	queued_shoot = false
	anim_player.play("shoot")
	anim_player.animation_finished.connect(_on_animation_finished)

func exit():
	anim_player.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName):
	if anim_name == "shoot":
		if queued_shoot == true:
			fsm.change_state("Ranged_Attack")
		else:
			fsm.change_state("Ready")

func update(_delta: float):
	if Input.is_action_just_pressed("shoot"):
		queued_shoot = true

func _shoot_bullet():
	
	# Calculate spawn position (Marker2D of gun)
	var spawn_pos = gun.global_position
	
	# Ask pool for a bullet
	var bullet = pool.spawn(spawn_pos, entity.facing_direction * Vector2.RIGHT)
	
	# If pool isn't empty and gave us a bullet, set it up
	if bullet:
		bullet.setup_projectile(entity.facing_direction * Vector2.RIGHT, owner, entity.get_total_damage(shoot_damage))
