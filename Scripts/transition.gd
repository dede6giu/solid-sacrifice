extends Area2D

@export var path = "res://Scenes/master_scene.tscn"  
@onready var transition: Area2D = $"."

var player = null  

func _on_body_entered(body: Node2D) -> void:
	player = body
	TransitionAnimation.changeScene("RightToLeft")
	player.isDead = true
	Global.VariableReset()

func _on_body_exited(body: Node2D) -> void:
	player = null

func _process(delta: float) -> void:
	if (TransitionAnimation.animated_transition.current_animation == "RightToLeft" and TransitionAnimation.animated_transition.current_animation_position > 1.4):
		if Global.comingFromMenu:
			TransitionAnimation.changeScene("OpenToLeft")
			handling()
			return
		if player:
			player.isDead = false
		handling()

func handling():
	if Global.goingToMenu:
		Global.goingToMenu.queue_free()
		Global.goingToMenu = null
		TransitionAnimation.changeScene("OpenToLeft")
		return
	
	if Global.comingFromMenu:
		Global.comingFromMenu = false
		var next_level = ResourceLoader.load("res://Scenes/levels/level-1.tscn").instantiate()
		var pos = next_level.get_node("SpawnPoint").position
		get_tree().get_root().get_node("MasterScene").get_node("Main2D").add_child(next_level)
		TransitionAnimation.changeScene("OpenToLeft")
		return
	
	var current_level = get_parent().get_parent()
	print(current_level)
	print(path)
	print(ResourceLoader.load(path))
	print(get_tree().get_root().get_node("MasterScene").get_node("Main2D").get_children())
	var next_level = ResourceLoader.load(path).instantiate()
	var pos = next_level.get_node("SpawnPoint").position

	Global.save_position_for_scene(str(current_level.get_instance_id()), pos)
	current_level.get_parent().add_child(next_level)
	current_level.queue_free()
	TransitionAnimation.changeScene("OpenToLeft")
	
