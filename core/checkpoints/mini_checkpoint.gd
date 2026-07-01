extends Area2D

@onready var game_manager = %GameManager
@onready var respawn_point = $RespawnPoint
@onready var checkpoint = $"."

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): # TODO: Create a group for player
		game_manager.last_safe_location = respawn_point.global_position
		print("New Spike Checkpoint: ", respawn_point.global_position) # debugging


# following has to be added in spike's script

#func _on_body_entered(body) -> void:
	#if(body == player):
		#player.position = game_manager.last_safe_location
