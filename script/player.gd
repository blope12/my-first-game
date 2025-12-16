extends CharacterBody2D

const SPEED = 100
const RUN_SPEED = 200  
const JUMP_VELOCITY = -300

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 800 * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var dir = 0
	if Input.is_key_pressed(KEY_A):
		dir -= 1
	if Input.is_key_pressed(KEY_D):
		dir += 1

	var current_speed = SPEED
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = RUN_SPEED

	velocity.x = dir * current_speed

	if dir != 0:
		if current_speed == RUN_SPEED:
			sprite.play("run")  
		else:
			sprite.play("walk")  
		sprite.flip_h = dir < 0

	move_and_slide()
