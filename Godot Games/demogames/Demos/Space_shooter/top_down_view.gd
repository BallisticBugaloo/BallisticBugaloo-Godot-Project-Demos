extends Node3D

@onready var cam_target := %Camera_Target
@onready var cam_control := $Space_ship/Camera_control

func _physics_process(delta: float) -> void:
	cam_control.global_position = lerp(cam_control.global_position,cam_target.global_position,0.1 * delta)
