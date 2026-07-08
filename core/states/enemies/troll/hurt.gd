extends State
class_name Hurt_troll

var max_iframes: float = 3.0
var iframes: float = max_iframes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():pass
	#entity.get_node("hurtbox").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if iframes<0:
		#iframes = max_iframes
		#fsm.change_state("search");
		#return
	#iframes -= delta
	pass
	
#func exit():
	#entity.get_node("hurtbox").visible = false
	
