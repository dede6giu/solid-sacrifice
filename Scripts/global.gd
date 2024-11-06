extends Node2D

static var saved_positions = {}

static func save_position_for_scene(scene_name: String, position: Vector2) -> void:
	saved_positions[scene_name] = position

static func get_position_for_scene(scene_name: String) -> Vector2:
	return saved_positions.get(scene_name, Vector2.ZERO)

static func clear_position_for_scene(scene_name: String) -> void:
	saved_positions.erase(scene_name)
