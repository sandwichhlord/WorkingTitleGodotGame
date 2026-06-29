extends Area2D

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.DOWN
@export var creater : Node = null


func _ready() -> void:
	#listen for when the bullet hits something
	body_entered.connect(_on_body_entered)
	pass
	

func setup_projectile(spawn_dir : Vector2, spawn_creator:Node) -> void:
	direction = spawn_dir.normalized()  #finds normalised direction and node which shoots
	creater = spawn_creator
	
func _physics_process(delta: float) -> void:
	global_position += direction*speed*delta
	print("bullet at: ",global_position.x , global_position.y)
	
func _on_body_entered(body : Node2D) -> void:
	if body == creater:
		return
		
	if body.is_in_group("player"):
		if body.has_method("recieve_hit"):
			body.recieve_hit(10)
		else:
			print("player doesnt have take damage function")
			
			
	visible = false
	process_mode = PROCESS_MODE_DISABLED
	pass
