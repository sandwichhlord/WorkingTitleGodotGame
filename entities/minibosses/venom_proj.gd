extends Area2D
@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.DOWN
@export var creator: Node = null

func _ready() -> void:
	# CollisionShape2D is already set up in the scene tree - no need to build one here

	# separate Hitbox child for actual damage dealing
	var bullet_shape = CircleShape2D.new()
	bullet_shape.radius = 4.0
	var hitbox = Hitbox.new(10.0, 0.0, bullet_shape, 1)
	add_child(hitbox)

	body_entered.connect(_on_body_entered)

func setup_projectile(spawn_dir: Vector2, spawn_creator: Node) -> void:
	direction = spawn_dir.normalized()
	creator = spawn_creator

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	# ignore the boss body
	if body == creator:
		return
	
	visible = false

	# turn off this bullet
	set_deferred("monitoring", false)

	for child in get_children():
		if child is Area2D:
			child.set_deferred("monitoring", false)

	# wait then delete
	await get_tree().create_timer(0.1).timeout
	queue_free()
