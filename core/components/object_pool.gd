extends Node
class_name ObjectPool

 #instead of hardcoding we use packed scene. We reference the projectile script via this instead of writing res:
@export var projectile_scene: PackedScene 
@export var pool_size: int = 15

var pool : Array[Node] = []


func _ready() -> void:
	if not projectile_scene:
		print("Parent Node doesnt have projectile blueprint")
		return
		
	for i in range(pool_size):
		var obj = projectile_scene.instantiate()
		_deactivate_object(obj)  #deactivate objects as soon as they are created
		
		if obj is CanvasItem:
			obj.top_level = true  #this tells us to ignore the parent nodes environment 
			
		add_child(obj)
		pool.append(obj)
		
		
func spawn(spawn_position:Vector2, spawn_direction:Vector2) -> Node:
	for obj in pool:
		if not obj.process_mode == PROCESS_MODE_INHERIT: #checks processing state of projectile 
			_activate_object(obj,spawn_position,spawn_direction,get_parent())
			return obj
		
	print("increase pool size")
	return null
		
	
func _activate_object(obj: Node, spawn_position: Vector2, direction: Vector2, creator: Node) -> void:
	if obj is Node2D:
		obj.global_position = spawn_position
		
	obj.visible = true
	obj.process_mode = PROCESS_MODE_INHERIT
	
	if obj.has_method("setup_projectile"):
		obj.setup_projectile(direction, creator)
		
		
		
func _deactivate_object(obj: Node) -> void:
	obj.visible = false
	obj.process_mode = PROCESS_MODE_DISABLED
