extends Area2D
var player = null
var inicial_player_pos = Vector2()
@onready var spawn = get_parent().get_parent().get_parent().get_node("SpawnPoint")
var statuePath = preload("res://Scenes/statue.tscn")

func create_statue(character_position: Vector2):
	var newStatue = statuePath.instantiate()
	Global.queue_management(newStatue.get_instance_id())
	if character_position.y >= get_parent().position.y:
		newStatue.position = - character_position + get_parent().position
	else:
		newStatue.position = character_position - get_parent().position
	newStatue.rotation_degrees = -get_parent().rotation_degrees
	newStatue.get_node("Box").get_node("AnimatedSprite2D").flip_h = player.get_node("AnimatedSprite2D").flip_h
	newStatue.get_node("Box").get_node("AnimatedSprite2D").animation_finished.connect(_on_death_finish)
	add_child(newStatue)
	print("Spawning at :", character_position)
	
func _on_body_entered(body: Node2D) -> void:
	inicial_player_pos = spawn.global_position
	player = body
	player.hide()
	#body.get().animated_sprite_2d.play("Death")
	create_statue(player.global_position)
	
func _on_death_finish() -> void:
	if player:
		print("Current position: ", player.global_position)
		player.position = inicial_player_pos
		player.show()
		print("Respawning on ", player.global_position)
		player = null
 
