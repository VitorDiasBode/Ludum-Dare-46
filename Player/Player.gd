extends KinematicBody2D

var energy = 100.0

var velocity = Vector2()
var speed = 0
var max_speed = 350
var look_direction = 1
var state = "run"

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP
		state = "walk"
	elif Input.is_action_pressed("move_down"):
		velocity = Vector2.DOWN
		state = "walk"
	elif Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT
		state = "walk"
		look_direction = -1
	elif Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT
		state = "walk"
		look_direction = 1
	else:
		velocity = Vector2()
		state = "idle"
	
	if Input.is_action_pressed("run") and velocity != Vector2():
		state = "run"
	
	velocity = move_and_slide(velocity*speed)
	set_animation()
	
	
	if state == "idle":
		speed = lerp(speed, 0, 0.5)
		
	elif state == "walk":
		$Interface/EnergyBar.value -= delta
		speed = lerp(speed, max_speed, 0.06)
	elif state == "run":
		$Interface/EnergyBar.value -= delta*2
		speed = lerp(speed, max_speed+400, 0.6)
	if $Interface/EnergyBar.value <= 0:
		get_tree().reload_current_scene()
	
	

func set_animation() -> void:
	if velocity != Vector2():
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	
	$AnimatedSprite.flip_h = ( look_direction < 0 )
