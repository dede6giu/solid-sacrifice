extends AudioStreamPlayer2D

var pitch = AudioServer.get_bus_effect(1, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pitch.pitch_scale = randf_range(0.8, 1.2)
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	queue_free()
