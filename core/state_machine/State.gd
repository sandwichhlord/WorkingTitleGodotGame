class_name State 
extends Node

# Explicit type definitions so your code autocomplete works perfectly

var fsm: Node
#add enemys when enemies are made
var enemy:
	get:
		return fsm.get_parent()
		
var player:
	get:
		return get_tree().get_first_node_in_group("Mainplayer")

# Virtual lifecycle methods to be overridden by child states
func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void: pass
