extends Node

const RESOURCE_PATHS : Dictionary = {}

var _resources : Dictionary = {}

func _ready() -> void:
	_load_resources()


func get_resource(resource_path: String) -> Object:
	var resource_paths = resource_path.split("/")
	if resource_paths.size() != 2:
		push_warning("Invalid resource path: " + str(resource_path))
		return null
	
	var resource_dictionary_name = resource_paths[0]
	var resource_name = resource_paths[1]
	
	if _resources.has(resource_dictionary_name):
		var resource_dictionary = _resources[resource_dictionary_name]
		if resource_dictionary.has(resource_name):
			return resource_dictionary[resource_name]
	
	push_warning("Missing resource: " + str(resource_path))
	return null


func get_resource_names() -> Dictionary:
	var loaded_resource_names: Dictionary = {}
	
	for resource_dictionary_name in _resources.keys():
		var resource_dictionary = _resources[resource_dictionary_name]
		var category_resources = []
		
		for resource_name in resource_dictionary.keys():
			category_resources.append(resource_name)
		
		loaded_resource_names[resource_dictionary_name] = category_resources
	
	return loaded_resource_names


func get_resource_count() -> int:
	var count = 0
	for resource_dictionary in _resources.values():
		count += resource_dictionary.size()
	
	return count


func _load_resources() -> void:
	for resource_dictionary_name in RESOURCE_PATHS.keys():
		_resources[resource_dictionary_name] = {}
		var resource_dictionary = RESOURCE_PATHS[resource_dictionary_name]
		
		for resource_name in resource_dictionary.keys():
			var path_to_resource = resource_dictionary[resource_name]
			if ResourceLoader.exists(path_to_resource):
				var resource = ResourceLoader.load(path_to_resource)
				_resources[resource_dictionary_name][resource_name] = resource
			else:
				push_error("Failed to load resource: " + str(resource_name) + " at path: " + str(path_to_resource))
