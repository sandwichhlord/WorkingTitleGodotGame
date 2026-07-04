extends State
class_name idle

# Called when the node enters the scene tree for the first time.
func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void: 
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mainplayer"):
		fsm.change_state("attack")
