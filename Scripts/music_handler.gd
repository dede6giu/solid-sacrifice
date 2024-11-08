extends AudioStreamPlayer
@onready var effects_handler: AnimationPlayer = $"Effects Handler"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.musicPlaying:
		Global.musicPlaying = true
		play()
		effects_handler.play("Volume Fade In")
