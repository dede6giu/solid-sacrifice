extends CanvasLayer
@onready var animated_transition: AnimationPlayer = $AnimatedTransition


# Called when the node enters the scene tree for the first time.
func changeScene(type : String = "RightToLeft"):
	if type == "RightToLeft":
		transition_RightToLeft()
	else:
		transition_OpenToLeft()
		
func transition_RightToLeft():
	animated_transition.play("RightToLeft")

func transition_OpenToLeft():
	animated_transition.play("OpenToLeft")
