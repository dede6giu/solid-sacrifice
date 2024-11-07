extends Area2D

@export var path = "res://Scenes/teste.tscn"  

var player = null  


func _on_body_entered(body: Node2D) -> void:
	player = body
	
	var current_level = get_parent().get_parent()   
	
	var next_level = ResourceLoader.load(path).instantiate()
	
	var pos = next_level.get_node("SpawnPoint").position

	Global.save_position_for_scene(str(current_level.get_instance_id()), pos)

	current_level.get_parent().add_child(next_level)
	
	current_level.queue_free()

func _on_body_exited(body: Node2D) -> void:
	player = null
