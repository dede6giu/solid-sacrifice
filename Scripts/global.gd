extends Node2D

static var saved_positions = {}

static var statue_limit = 2;
static var box_queue = []
static var statueBreak = null

static var chaves = []

func Reset(id: int, path: String) -> void:
	var current_scene_name = instance_from_id(id).name
	var nextMap = ResourceLoader.load(path).instantiate()
	instance_from_id(id).get_parent().add_child(nextMap)
	instance_from_id(id).queue_free()
	chaves.clear()
	box_queue.clear()

static func queue_management(id: int) -> void:
	box_queue.push_back(id)
	if box_queue.size() > statue_limit:
		# break first
		statueBreak = instance_from_id(box_queue.pop_front())
		statueBreak.get_node("Box").get_node("AnimatedSprite2D").animation_finished.connect(_on_box_death)
		statueBreak.get_node("Box").get_node("AnimatedSprite2D").play("Break")
	if box_queue.size() == statue_limit:
		# crack first
		var crackS = box_queue.front()
		instance_from_id(crackS).get_node("Box").get_node("AnimatedSprite2D").play("Crack")
	
static func _on_box_death():
	statueBreak.queue_free()
	statueBreak = null
	
static func save_position_for_scene(scene_name: String, position: Vector2) -> void:
	saved_positions[scene_name.to_lower()] = position

static func get_position_for_scene(scene_name: String) -> Vector2:
	return saved_positions.get(scene_name.to_lower(), Vector2.ZERO)

static func clear_position_for_scene(scene_name: String) -> void:
	saved_positions.erase(scene_name.to_lower())
