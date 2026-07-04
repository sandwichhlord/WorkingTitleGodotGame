extends State
class_name attackk

var time: float
var y_speed: float
@export var max_cooldown_attack:float = 1
var cooldown_attack: float = max_cooldown_attack
var airtimer = 0
@export var extra_airtime = 1
var has_shot = false
var player
@export var shape: Shape2D = RectangleShape2D.new()



# Called when the node enters the scene tree for the first time.
func enter() -> void: 
	print("entering enter")
	player = get_tree().get_first_node_in_group("Mainplayer")
	shape.size = Vector2(55, 50)
	entity.bullet.create_hitbox(
	10,
	0.0,
	shape,
	1
)
	

func exit() -> void: 
	print("exiting")
	entity.bullet.remove_hitbox()
	#entity.bullet.visible = false


func update(delta: float) -> void:
	if cooldown_attack <= 0:
		if !has_shot:
			has_shot = true
			entity.bullet.visible = true
			print(entity.bullet.initialpos)
			entity.bullet.position = entity.bullet.initialpos
			entity.bullet.velocity = Vector2(-entity.x_speed, y_speed)

		airtimer -= delta
		
		if airtimer <= 0:
			has_shot = false
			cooldown_attack = max_cooldown_attack
			entity.bullet.visible = false
			entity.bullet.global_position = entity.bullet.spawn_position
			entity.bullet.velocity = Vector2.ZERO
			
		return
	time = -(player.position.x - entity.position.x)/(entity.x_speed)
	airtimer = time + extra_airtime
	y_speed = -entity.get_gravity().y*time*0.5
	
	#print(time)
	#print(y_speed)
	
	cooldown_attack-=delta
	
		
	


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mainplayer"):
		fsm.change_state("idle")
