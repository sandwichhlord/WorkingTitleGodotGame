extends Node
class_name fsm

@export var initial_state: State
var current_state: State


# theres a fsm variable in the state class which points to  
# the fsm to which that state belongs to
# _ready() assigns the current fsm to all its children
func _ready() -> void:
	await get_parent().ready

	var body = self.get_parent()
	for child in get_children():
		if child is State:
			child.fsm = self            
			
			child.entity = body
	current_state = initial_state
	current_state.enter()


# typical physics process
func _physics_process(delta: float) -> void:
	
	if current_state:
		current_state.update(delta)


# just calls the exit function of this state and enter of the next
func change_state(target_state_name: String) -> void:
	var new_state = get_node(target_state_name) as State
	if not new_state: 
		return
		
	if current_state != null :
		current_state.exit()
	current_state = new_state
	current_state.enter()
	
