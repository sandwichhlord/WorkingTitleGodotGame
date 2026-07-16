extends Node

const SaveLocationPath: String = "user://game_save.json" # ~/ (user folder because game fodler becomes read only after export)
const UUIDKey = "dd7f94a6-17c8-49e6-ad89-24df5ce13a20"
var save_data: Dictionary = {
	"player_position_x": 10, 
	"player_position_y": 10 
}

func _ready():
	_load()

func _save() -> void:
	var file: FileAccess = FileAccess.open_encrypted_with_pass(SaveLocationPath, FileAccess.WRITE, UUIDKey)
	file.store_var(save_data)
	file.close()

func _load() -> void:
	if FileAccess.file_exists(SaveLocationPath):
		var file: FileAccess = FileAccess.open_encrypted_with_pass(SaveLocationPath, FileAccess.READ, UUIDKey)
		var data: Dictionary = file.get_var()
		
		for i in data: # Update support (adding enw features
			if save_data.has(i):
				save_data[i] = data[i]

		file.close()
