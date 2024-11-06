extends Area2D
@onready var timer = $Timer
var player = null
var inicial_player_pos = Vector2()
@onready var spawn = get_parent().get_parent().get_parent().get_node("SpawnPoint")
var statuePath = preload("res://Scenes/statue.tscn")

func _ready():
	print(spawn)

func create_statue(character_position: Vector2):
	var newStatue = statuePath.instantiate()
	Global.queue_management(newStatue.get_instance_id())
	if character_position.y >= get_parent().position.y:
		newStatue.position = - character_position + get_parent().position
	else:
		newStatue.position = character_position - get_parent().position
	add_child(newStatue)
	print("Spawning at :", character_position)

func _on_body_entered(body: Node2D) -> void:
	inicial_player_pos = spawn.global_position
	player = body
	timer.start()
	player.hide()
	#body.get().animated_sprite_2d.play("Death")
	create_statue(player.global_position)
	
func _on_timer_timeout() -> void:
	if player:
		print("Current position: ", player.global_position)
		player.position = inicial_player_pos
		player.show()
		print("Respawning on ", player.global_position)
		player = null
