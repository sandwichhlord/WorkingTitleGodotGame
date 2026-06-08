extends Node
class_name HealthComponent

signal health_changed(current_health: float, max_health: float)
signal damage_taken(amount: float)
signal healed(amount: float)
signal died

@export var max_health: float = 100.0
var current_health: float



func _ready() -> void:
	current_health = max_health

func take_damage(amount: float) -> void:
	#print("take_damage funct of HealtComponent called")
	
	if current_health <= 0:
		return # is already dead, ignore incoming damage
		
	current_health -= amount
	current_health = clamp(current_health, 0.0, max_health)
	
	# emit signals so parent nodes and stuff know what happened
	health_changed.emit(current_health, max_health)
	damage_taken.emit(amount)
	print("damage taken: ", amount, " health remaining: ", current_health)
	
	
	if current_health <= 0:
		print("died")
		died.emit()

func heal(amount: float) -> void:
	if current_health <= 0:
		return # cant heal the dead
		
	current_health += amount
	current_health = clamp(current_health, 0.0, max_health)
	
	health_changed.emit(current_health, max_health)
	healed.emit(amount)
	
