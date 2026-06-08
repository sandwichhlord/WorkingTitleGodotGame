extends Area2D
class_name  Hitbox

var hitbox_lifetime: float
var shape : Shape2D
var target_mask: int
var damage: float

# just assigning the variables on initialization
# as this isnt a permanent thing and only appears when attacks
#
# For infinitely long hitbox, set timer = 0.0
func _init(_damage: float, _hitbox_lifetime : float, _shape : Shape2D, _target_mask: int) -> void:
	hitbox_lifetime = _hitbox_lifetime
	shape = _shape
	target_mask = _target_mask
	damage = _damage
	
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
	if hitbox_lifetime > 0.0 :
		var new_timer = Timer.new()
		add_child(new_timer)
		new_timer.timeout.connect(queue_free)
		new_timer.call_deferred("start",hitbox_lifetime)
	
	if shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = shape
		add_child(collision_shape)
		
	# refer to hurtbox script, same thing happening here
	set_collision_layer_value(1,false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(target_mask, true)
	
# default on area entered script
# if area doesnt have recieve hit dont do anything
func _on_area_entered(area: Area2D) -> void:
	#print("area entered")
	if not area.has_method("recieve_hit"):
		return
	area.recieve_hit(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
