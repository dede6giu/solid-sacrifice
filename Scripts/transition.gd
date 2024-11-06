extends Area2D

@export var path = "res://Scenes/teste.tscn"

func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(path)
	
