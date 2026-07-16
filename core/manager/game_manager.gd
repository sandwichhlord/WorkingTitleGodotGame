extends Node

var isCheckpointBoss: bool # For boss difficulty changing (later update)
var boss_death_count;
var last_set_location # main checkpoint's location
var last_safe_location # if player falls into trap, it'll respawn here

func _ready() -> void: # This runs only once when we boot up the game
	isCheckpointBoss = false
	last_set_location = player.global_position
