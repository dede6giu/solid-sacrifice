extends Node2D

@onready var key: CharacterBody2D = $Key
@onready var key_collect: Area2D = $Key/keyCollect
@onready var door_sprite: AnimatedSprite2D = $Door/AnimatedSprite2D
@onready var key_sprite: AnimatedSprite2D = $Key/AnimatedSprite2D
@onready var door_hitbox: CollisionShape2D = $Door/CollisionShape2D
@onready var door_area: Area2D = $Door/DoorArea
var collected := false
var player = null


func open_door():
	door_sprite.play("Open")

func _on_key_collect_body_entered(body: Node2D) -> void:
	key_collect.set_deferred("monitoring", false)
	collected = true
	Global.chaves.push_back(key)
	player = body
	print(Global.chaves)
func _on_door_area_body_entered(body: Node2D) -> void:
	if Global.chaves.size() >= 1:
		Global.chaves.pop_front().hide()
		open_door()
		door_area.set_deferred("monitoring", false)
		collected = false
		print(Global.chaves)

func _physics_process(delta):	
	if collected:
		_calculate_velocity()
		key.move_and_slide()
		
func _calculate_velocity():
	var distanceToPlayer = 5
	var keyNumber = 0 # (what key number is this?)
	var keyMultiplier = 1 if keyNumber == 0 else keyNumber
	var playerPosition = player.position - Vector2(0, 0)
	var SPEED = player.SPEED * 2
	var JUMP_VELOCITY = player.JUMP_VELOCITY - 50
		
	if key.position.distance_to(playerPosition) > distanceToPlayer * keyMultiplier:
		var direction = (playerPosition - key.position).normalized()
		key.velocity = direction * SPEED
		key.velocity.y == 3		
		if abs(key.position.x - playerPosition.x) > distanceToPlayer * keyMultiplier:
			key.velocity.x = key.velocity.x  * key.position.distance_to(playerPosition)/30
		else:
			key.velocity.x = 0
		
	elif key.position.y - playerPosition.y < -2 || key.position.y - playerPosition.y > 2:
		key.velocity.x = 0
	
	else:
		key.velocity = Vector2.ZERO

func _on_animated_sprite_2d_animation_finished() -> void:
	door_hitbox.set_deferred("disabled", true)
