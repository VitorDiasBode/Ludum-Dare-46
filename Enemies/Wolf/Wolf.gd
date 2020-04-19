extends KinematicBody2D

var speed = 330
var movement = Vector2()
var direction = Vector2()
var state = "idle"
var player 
var path

func _physics_process(delta):
	if state == "seek":
		if path.size() > 0:
			direction = global_position.direction_to(path[0])
			global_position = global_position.move_toward(path[0], delta*speed)
			set_animation()
			
			if global_position.distance_to(path[0]) <= .5:
				path.remove(0)
			
		
	

func set_animation():
	if state == "idle":
		$AnimatedSprite.play("idle")
	elif state == "seek":
		$AnimatedSprite.flip_h = (direction.x < 0)
		$AnimatedSprite.play("walk")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		$Timer.start(0.2)
		
	

func _on_Timer_timeout():
	path = get_parent().get_node("Navigation2D").get_simple_path( global_position, player.global_position, false)
	$Node/Line2D.points = path
	path.remove(0)
	state = "seek"
	
