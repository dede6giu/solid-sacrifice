extends Node2D

@onready var waah_sfx: AudioStreamPlayer2D = $WaahSFX
@onready var stone_sfx: AudioStreamPlayer2D = $WaahSFX/StoneSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	waah_sfx.play()


func _on_waah_sfx_finished() -> void:
	stone_sfx.play()


func _on_stone_sfx_finished() -> void:
	waah_sfx.queue_free()
