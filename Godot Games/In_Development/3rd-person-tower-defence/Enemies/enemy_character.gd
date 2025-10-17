extends CharacterBody3D

@export var SPEED:float = 2.0
var gravity_speed:float = 1.0

@onready var target_node = get_node("/root/Test_top_down_game/Player_one")

func _physics_process(delta: float) -> void:
	var face_direction = target_node.global_position
	print(face_direction)
	var target_direction := Vector3.FORWARD.signed_angle_to(face_direction, Vector3.UP)
	global_rotation.y = target_direction
	
	#var direction = global_position.direction_to(target_node.global_position)
	#direction.y = 0.0
	#velocity = direction * SPEED
	#
	#rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)
	#
	#look_at(target_node.global_position)
	#move_and_slide() 
