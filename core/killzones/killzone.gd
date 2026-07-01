extends Area2D

@onready var game_manager = %GameManager
@onready var respawn_point = $RespawnPoint
@onready var checkpoint = $"."

@onready var timer = $Timer

func _on_body_entered(body):
	if(body == player):
		#damage (10) # Debugging
		# animation
		body.get_node("CollisionShape2D").set_deferred("disabled", true) # disabling so that it doesn't constantly damage player
		timer.start()


func _on_timer_timeout(body):
	player.position = game_manager.last_safe_location
	body.get_node("CollisionShape2D").set_deferred("disabled", false)
