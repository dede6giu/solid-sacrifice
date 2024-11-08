extends Control

@onready var btn_game: Button = $Menu/Button
@onready var btn_quitgame: Button = $Menu/Button2
@onready var btn_credits: Button = $Menu/Button3

var level_instance : Node2D
@onready var main_2d: Node2D = $Main2D
@onready var menu: Control = $Menu
@onready var hud: CanvasLayer = $HUD
@onready var to_menu: Button = $"HUD/To Menu"

func _ready() -> void:
	hud.set_deferred("visible", false)

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String) -> void:
	unload_level()
	var level_path : String = "res://Scenes/levels/%s.tscn" % level_name
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
	# play game
	btn_game.release_focus()
	hideUI()
	Global.comingFromMenu = true
	Global.comingMenuScene = "res://Scenes/levels/level-1.tscn"
	TransitionAnimation.changeScene("RightToLeft")
	hud.set_deferred("visible", true)


func _on_button_2_pressed() -> void:
	# quit game
	hideUI()
	get_tree().quit()


func _on_to_menu_pressed() -> void:
	to_menu.release_focus()
	hud.set_deferred("visible", false)
	var activeMaps = get_node("Main2D").get_children()[0]
	Global.goingToMenu = activeMaps
	Global.VariableReset()
	TransitionAnimation.changeScene("RightToLeft")
	showUI()


func _on_button_3_pressed() -> void:
	# play credits
	btn_credits.release_focus()
	hideUI()
	Global.comingFromMenu = true
	Global.comingMenuScene = "res://Scenes/creditos.tscn"
	TransitionAnimation.changeScene("RightToLeft")
	hud.set_deferred("visible", true)
