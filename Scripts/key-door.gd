extends Node2D

@onready var key: Area2D = $Key
@onready var door_sprite: AnimatedSprite2D = $Door/AnimatedSprite2D
@onready var door_hitbox: CollisionShape2D = $Door/CollisionShape2D

func open_door():
	door_sprite.play("Open")
	door_hitbox.set_deferred("disabled", true)

func _on_key_body_entered(body: Node2D) -> void:
	key.set_deferred("monitoring", false)
	key.hide()
	open_door()
