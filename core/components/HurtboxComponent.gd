extends Area2D
class_name hurtbox
@export var target_mask = 1

# by default it monitors layer one, but we want it to monitor whichever
# layer the other entity is in
#
# if all enemies were in layer 2 and also were monitoring layer 2, theyd
# hit each other
# enemies hurtbox need to monitor particular layer and have their hitbox 
# emit in another layer
func _ready() -> void:
	monitoring = false
	set_collision_layer_value(1,false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(target_mask, true)

# if owner has health component, damage it by damage amount
func recieve_hit(damage: float) -> void:
	#print("recieve_hit activated")
	
	if owner.has_node("HealthComponent"):
		#print("health node found")
		owner.get_node("HealthComponent").take_damage(damage)

# default process function
func _process(delta: float) -> void:
	pass
