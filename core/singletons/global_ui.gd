extends CanvasLayer

@onready var label = $Panel/Label

var curr_pages : Array[String] = []
var page_index : int = 0

func _ready() -> void:
	self.hide()
	

func display_dialogue(pages : Array[String]) -> void:
	curr_pages = pages
	page_index = 0
	show_page()
	self.show()
	

func show_page() -> void:
	label.text = curr_pages[page_index]
	
func _input(event : InputEvent) -> void:
	if self.visible and event.is_action_pressed("ui_accept"):
		page_index += 1
		
		if page_index < curr_pages.size():
			show_page()
		else:
			self.hide()
