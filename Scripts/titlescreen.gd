extends Control
@onready var statue_change: Timer = $"Statue Change"
var timerStatus := 0
@onready var button_label: Label = $Button/ButtonLabel
@onready var character: AnimatedSprite2D = $Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timerStatus = 2
	statue_change.wait_time = randf_range(4, 8)
	statue_change.start()

func _on_statue_change_timeout() -> void:
	var enter = timerStatus
	while timerStatus == enter:
			timerStatus = randi_range(0, 2)
	if timerStatus == 0:
		# case normal    -> halfstone
		character.play("halfstone")
		print(timerStatus)
		statue_change.wait_time = randf_range(0.5, 5)
		statue_change.start()
		# timerStatus = 1
	elif timerStatus == 1:
		# case halfstone -> statue
		character.play("stone")
		print(timerStatus)
		statue_change.wait_time = randf_range(0.5, 3)
		statue_change.start()
		# timerStatus = 2
	else:
		# case statue    -> normal
		character.play("normal")
		print(timerStatus)
		statue_change.wait_time = randf_range(4, 8)
		statue_change.start()
		# timerStatus = 0


func _on_button_label_mouse_entered() -> void:
	pass # Replace with function body.

func _on_button_label_mouse_exited() -> void:
	pass # Replace with function body.

func _on_button_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_just_pressed('mouse_click'):
			print('clicked!')
 
