extends KinematicBody2D

var energy = 100.0

var velocity = Vector2()
var speed = 500
var look_direction = 1

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP
	elif Input.is_action_pressed("move_down"):
		velocity = Vector2.DOWN
	elif Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT
		look_direction = -1
	elif Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT
		look_direction = 1
	else:
		velocity = Vector2()
	
	velocity = move_and_slide(velocity*speed)
	set_animation()
	

func set_animation() -> void:
	if velocity != Vector2():
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	
	$AnimatedSprite.flip_h = ( look_direction < 0 )
