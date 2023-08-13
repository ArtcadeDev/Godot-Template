extends Node

var _save_path : String = "user://save_file.cfg"
var _config : ConfigFile = ConfigFile.new()
var _load_response : int = _config.load(_save_path)

func _ready() -> void:
	_check_load_response(_load_response)


func save_data(section: String, key: String, value: Variant) -> void:
	_config.set_value(section, key, value)
	_config.save(_save_path)


func load_data(section: String, key: String, value: Variant) -> Variant:
	value = _config.get_value(section, key, value)
	return value


func _check_load_response(response: int):
	if response != null:
		print("Save file loaded successfully.")
	else:
		push_error("Failed to load save file")
