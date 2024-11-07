extends Control

@onready var btn_game: Button = $Menu/Button
@onready var btn_quitgame: Button = $Menu/Button2
@onready var btn_teste: Button = $Menu/Button3
var level_instance : Node2D
@onready var main_2d: Node2D = $Main2D
@onready var menu: Control = $Menu

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String) -> void:
	unload_level()
	var level_path : String = "res://Scenes/%s.tscn" % level_name
	var level_resource : PackedScene = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		Global.save_position_for_scene(level_name, level_instance.get_node("SpawnPoint").position)
		main_2d.add_child(level_instance)

func hideUI() -> void:
	menu.set_deferred("visible", false)

func showUI() -> void:
	menu.set_deferred("visible", true)


func _on_button_pressed() -> void:
	hideUI()
	load_level("levels/medium_level")
	btn_game.release_focus()


func _on_button_2_pressed() -> void:
	hideUI()
	get_tree().quit()


func _on_button_3_pressed() -> void:
	hideUI()
	load_level("levels/easy_level")
	btn_teste.release_focus()
