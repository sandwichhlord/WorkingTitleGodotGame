extends Area2D

@onready var game_manager = %GameManager
@onready var respawn_point = $RespawnPoint
@onready var checkpoint = $"."

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): # TODO: Create a group for player
		game_manager.last_set_location = respawn_point.global_position
		print("New Checkpoint: ", respawn_point.global_position) # Debugging

# func _on_player_died(body) -> void: # death
	#if(body == player):
		#player.position = game_manager.last_set_location
