extends CharacterBody2D

class_name ball

const SPEED: float = 980.0 #900.0

var dir = Vector2(1,-1)
var click_position = Vector2.ZERO


func _ready(): 
	velocity += transform.x * SPEED

func _physics_process(delta):
	
	var collision_object = move_and_collide(velocity *  delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.get_normal())


func _on_area_2d_area_entered(area):
	queue_free()

