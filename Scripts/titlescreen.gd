extends Control
@onready var statue_change: Timer = $"Statue Change"
var timerStatus := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timerStatus = 0
	statue_change.wait_time = randf_range(7, 15)
	statue_change.start()

func _on_statue_change_timeout() -> void:
	if timerStatus == 0:
		# case normal    -> halfstone
		print(timerStatus)
		statue_change.wait_time = randf_range(1, 3)
		statue_change.start()
		timerStatus = 1
	elif timerStatus == 1:
		# case halfstone -> statue
		print(timerStatus)
		statue_change.wait_time = randf_range(2, 7)
		statue_change.start()
		timerStatus = 2
	else:
		# case statue    -> normal
		print(timerStatus)
		statue_change.wait_time = randf_range(7, 15)
		statue_change.start()
		timerStatus = 0
