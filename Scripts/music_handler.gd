extends AudioStreamPlayer2D
@onready var effects_handler: AnimationPlayer = $"Effects Handler"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	effects_handler.play("Volume Fade In")
