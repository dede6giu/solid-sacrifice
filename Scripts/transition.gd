extends Area2D

@export var path = "res://Scenes/game.tscn"  

var player = null  

func _on_body_entered(body: Node2D) -> void:
	player = body
	TransitionAnimation.changeScene("RightToLeft")
	player.isDead = true

func _on_body_exited(body: Node2D) -> void:
	player = null

func _process(delta: float) -> void:
	if (TransitionAnimation.animated_transition.current_animation == "RightToLeft" and TransitionAnimation.animated_transition.current_animation_position > 1.4):
		player.isDead = false
		var current_level = get_parent().get_parent()   
		
		var next_level = ResourceLoader.load(path).instantiate()
		
		var pos = next_level.get_node("SpawnPoint").position

		Global.save_position_for_scene(str(current_level.get_instance_id()), pos)

		current_level.get_parent().add_child(next_level)
		
		current_level.queue_free()
		
		TransitionAnimation.changeScene("OpenToLeft")
