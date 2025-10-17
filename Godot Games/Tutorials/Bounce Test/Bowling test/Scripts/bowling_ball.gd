extends RigidBody3D

var vel_speed = 52.0

func _ready():
	linear_velocity.z = move_toward(linear_velocity.z, -vel_speed, vel_speed - 4.0)

