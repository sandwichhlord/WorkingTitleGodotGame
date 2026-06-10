class_name State 
extends Node

# Explicit type definitions so your code autocomplete works perfectly

var fsm: Node

# Virtual lifecycle methods to be overridden by child states
func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void: pass
