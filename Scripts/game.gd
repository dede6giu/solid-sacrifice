extends Node2D
@export var statueAmount = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.statue_limit = statueAmount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
