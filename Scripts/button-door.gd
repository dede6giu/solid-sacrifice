extends Node2D

@onready var plate: Area2D = $Plate
@onready var plate_sprite: AnimatedSprite2D = $"Plate/plate-sprite"
@onready var closed: CollisionShape2D = $Door/Closed
@onready var partially_closed: CollisionShape2D = $Door/PartiallyClosed
@onready var door_sprite: AnimatedSprite2D = $"Door/door-sprite"
var pressed := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if door_sprite.animation == "open":
		if door_sprite.frame >= 4 and door_sprite.frame < 8:
			closed.set_deferred("disabled", true)
			partially_closed.set_deferred("disabled", true)	
		elif door_sprite.frame < 4 and door_sprite.frame > 0:
			closed.set_deferred("disabled", true)
			partially_closed.set_deferred("disabled", true)	
	
func open_door():
	door_sprite.animation_finished.connect(_on_door_open_finish)
	door_sprite.play("open")
func close_door():
	door_sprite.animation_finished.connect(_on_door_close_finish)
	door_sprite.play_backwards("open")

func _on_exit_plate_finish():
	plate_sprite.animation_finished.disconnect(_on_exit_plate_finish)
	plate_sprite.play("idle")

func _on_door_open_finish():
	door_sprite.animation_finished.disconnect(_on_door_open_finish)
	closed.set_deferred("disabled", true)
	partially_closed.set_deferred("disabled", true)
	
func _on_door_close_finish():
	door_sprite.animation_finished.disconnect(_on_door_close_finish)
	door_sprite.play("idle")
	closed.set_deferred("disabled", false)
	partially_closed.set_deferred("disabled", false)
	
func _on_plate_body_entered(body: Node2D) -> void:
	if !pressed:
		plate_sprite.play("press")
		pressed = true
		open_door()

func _on_plate_body_exited(body: Node2D) -> void:
	if !plate.get_overlapping_areas():
		plate_sprite.animation_finished.connect(_on_exit_plate_finish)
		plate_sprite.play_backwards("press")
		pressed = false
		close_door()
