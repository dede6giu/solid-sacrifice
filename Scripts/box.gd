extends RigidBody2D

var player = null
var isBeingControlled := false
var isNearPlayer := false
var directionPlayer := false # 0: right; 1: left
var boxBelow = null
@onready var collision_left: CollisionShape2D = $CollisionLeft
@onready var collision_right: CollisionShape2D = $CollisionRight
@onready var collision_check: Timer = $"Collision Check"
@onready var box_beneath: Area2D = $"Box Beneath"

	
func _physics_process(delta: float) -> void:
	collision_check.autostart = true
	if isNearPlayer and player.heldBoxID == get_instance_id():
		isBeingControlled = Input.is_action_pressed("interact_hold")
	else:
		isBeingControlled = false
		
	if isBeingControlled:
		if directionPlayer:
			collision_left.set_deferred("disabled", false)
			collision_right.set_deferred("disabled", true)
		else: 
			collision_left.set_deferred("disabled", true)
			collision_right.set_deferred("disabled", false)
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			linear_velocity.x = player.BOXHOLDSPEED * direction
		else:
			linear_velocity.x = move_toward(linear_velocity.x, 0, player.BOXHOLDSPEED)
		gravity_scale = 1
	else:
		collision_left.set_deferred("disabled", true)
		collision_right.set_deferred("disabled", true)
	
		if boxBelow:
			gravity_scale = 1
			linear_velocity.x = boxBelow.linear_velocity.x
			linear_velocity.y = 0

		else:
			gravity_scale = 1
	linear_velocity.y += 1


func enter_area(body: Node2D) -> void:
	if !body.heldBoxID:
		body.isNearBox = true
		body.heldBoxID = get_instance_id()
		isNearPlayer = true
		player = body
		linear_damp = 0


func _on_left_body_entered(body: Node2D) -> void:
	if body:
		if !body.get_node("./AnimatedSprite2D").flip_h:
			directionPlayer = true
			enter_area(body)

func _on_right_body_entered(body: Node2D) -> void:
	if body:
		if body.get_node("./AnimatedSprite2D").flip_h:
			directionPlayer = false
			enter_area(body)


func left_area(body: Node2D) -> void:
	if body.heldBoxID == get_instance_id():
		body.heldBoxID = null
		body.isNearBox = false
		isNearPlayer = false
		isBeingControlled = false
		player = null
		linear_damp = 0.1
		collision_left.set_deferred("disabled", false)
		collision_right.set_deferred("disabled", false)

func _on_left_body_exited(body: Node2D) -> void:
	left_area(body)
func _on_right_body_exited(body: Node2D) -> void:
	left_area(body)
	
func _on_box_beneath_area_entered(area: Area2D) -> void:
	if area:
		gravity_scale = 0
		boxBelow = area.get_parent()

func _on_box_beneath_area_exited(area: Area2D) -> void:
	gravity_scale = 1
	boxBelow = null


func _on_collision_check_timeout() -> void:
	if !box_beneath.get_overlapping_areas():
		boxBelow = null
		
		gravity_scale = 1
		 
