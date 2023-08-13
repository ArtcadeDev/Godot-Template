extends Node

var _tree : SceneTree

func _ready() -> void:
	_tree = get_tree()


func instance_scene(scene_path: PackedScene, position: Vector2, rotation: float) -> Variant:
	if scene_path:
		var main_scene = _get_main_scene(_tree)
		var instance = _add_instance_to_scene(scene_path, main_scene)
		_set_instance_transform(instance, position, rotation)
		return instance
	else:
		push_warning("Failed to instance scene, possible typo: " + str(scene_path))
		return null


func _set_instance_transform(instance: Variant, position: Vector2, rotation: float) -> void:
	instance.global_position = position
	instance.global_rotation = rotation


func _add_instance_to_scene(scene_path: PackedScene, main_scene: Node) -> Object:
	var instance = scene_path.instantiate()
	main_scene.call_deferred("add_child", instance)
	return instance


func _get_main_scene(scene_tree: SceneTree) -> Node:
	var root_node = scene_tree.get_root()
	var child_count = root_node.get_child_count()
	
	# Only works if the current scene is the last child in the root
	if child_count > 0:
		var main_scene = root_node.get_child(child_count - 1)
		return main_scene
		
	push_warning("Main scene not found")
	return null
