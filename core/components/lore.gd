extends Area2D

# multiline as it allows us to have more lines displayed
@export_multiline var lore_text : String 
# if player in range he can interact
@export var player_in_range : bool = false

@export var pages : Array[String] = []

@onready var interact_prompt = $InteractPrompt

func _ready() -> void:
	pages.assign(lore_text.split("|")) # write like text1 | text2 | text3 | and so on it will show one at a time
	
	#connect signals for body entered and exited
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	interact_prompt.hide()

func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		interact_prompt.show()

func _on_body_exited(body : Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		interact_prompt.hide()

func _input(event : InputEvent) -> void:
	if player_in_range and event.is_action_pressed("ui_accept") and not GlobalUI.visible:
		GlobalUI.display_dialogue(pages)
		interact_prompt.hide()
		get_viewport().set_input_as_handled()

func _process(_delta: float) -> void:
	interact_prompt.visible = player_in_range and not GlobalUI.visible
