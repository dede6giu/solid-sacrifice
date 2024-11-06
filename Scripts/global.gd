extends Node2D

static var saved_positions = {}

static func save_position_for_scene(scene_name: String, position: Vector2) -> void:
	saved_positions[scene_name.to_lower()] = position
	print (scene_name.to_lower())
	print (saved_positions.get(scene_name.to_lower(), Vector2.ZERO))

static func get_position_for_scene(scene_name: String) -> Vector2:
	print (scene_name.to_lower())
	print (saved_positions.get(scene_name.to_lower(), Vector2.ZERO))
	return saved_positions.get(scene_name.to_lower(), Vector2.ZERO)

static func clear_position_for_scene(scene_name: String) -> void:
	saved_positions.erase(scene_name.to_lower())
