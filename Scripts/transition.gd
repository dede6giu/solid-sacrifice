extends Area2D

@export var path = "res://Scenes/teste.tscn"  

@export var pos = Vector2(0,0)

@export var cena = ""

var player = null  


func _on_body_entered(body: Node2D) -> void:
	player = body  

	Global.save_position_for_scene(cena, pos)

	get_tree().change_scene_to_file(path)

func _on_body_exited(body: Node2D) -> void:
	player = null
