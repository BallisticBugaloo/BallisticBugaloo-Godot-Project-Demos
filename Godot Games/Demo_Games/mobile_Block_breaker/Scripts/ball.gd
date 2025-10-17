extends CharacterBody2D

var SPEED = 30.0

func _physics():
	velocity.y -= SPEED
	
	move_and_slide()
