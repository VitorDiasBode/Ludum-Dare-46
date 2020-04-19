extends KinematicBody2D

var speed = 330
var direction = Vector2()
var state = "idle"
var player 

func _physics_process(delta):
	if state == "follow":
		move_and_slide(direction*speed)
			
		

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		$Timer.start(0.2)
		
	

func _on_Timer_timeout():
	if global_position.distance_to(player.global_position) < 500:
		direction = global_position.direction_to(player.global_position)
		state = "follow"
	
