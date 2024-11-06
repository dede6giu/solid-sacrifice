# Player.gd
extends CharacterBody2D

const SPEED := 100.0
const BOXHOLDSPEED := SPEED / 2
const JUMP_VELOCITY := -150.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var isJump := false
var isFreeFall := false
var isHoldingBox := false
var isNearBox := false
var heldBoxID = null
@onready var free_fall_timer: Timer = $FreeFallTimer

var is_position_restored := false  


func _ready() -> void:
	if is_position_restored:
		return 
	
	
	await get_tree().create_timer(0).timeout 


	var current_scene_name = get_tree().current_scene.name

	var saved_position = Global.get_position_for_scene(current_scene_name)

	position = saved_position
	
	is_position_restored = true
	
	if not is_on_floor():
		velocity.y = 0  
		
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		isJump = false
		isFreeFall = false
		free_fall_timer.stop()
		if isNearBox and Input.is_action_pressed("interact_hold"):
			isHoldingBox = true
		else:
			isHoldingBox = false

	# Handle jump.
	if !isHoldingBox and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("Jump")
		isJump = true

	var direction := Input.get_axis("move_left", "move_right")
	if !isHoldingBox:
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0: 
			animated_sprite_2d.flip_h = true
	
		if !isJump and velocity.y <= 0:
			if direction == 0:
				animated_sprite_2d.play("Idle")
			else:
				animated_sprite_2d.play("Walk")
		elif velocity.y > 0 and !isFreeFall:
			isFreeFall = true
			animated_sprite_2d.play("FreeFall_A")
			free_fall_timer.start()
	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if animated_sprite_2d.flip_h:
			if direction > 0:
				animated_sprite_2d.play("Pull")
			elif direction < 0: 
				animated_sprite_2d.play("Push")
			else:
				animated_sprite_2d.play("Hold_Idle")
		else:
			if direction > 0:
				animated_sprite_2d.play("Push")
			elif direction < 0: 
				animated_sprite_2d.play("Pull")
			else:
				animated_sprite_2d.play("Hold_Idle")
		
		if direction:
			velocity.x = direction * BOXHOLDSPEED
		else:
			velocity.x = move_toward(velocity.x, 0, BOXHOLDSPEED)
	
	move_and_slide()

func _on_free_fall_timer_timeout() -> void:
	if not is_on_floor():
		animated_sprite_2d.play("FreeFall_B")
