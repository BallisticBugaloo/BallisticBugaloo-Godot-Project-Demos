extends Node3D

@onready var _camera_controller: Node3D = $%Character/CameraController

func _physics_process(delta: float) -> void:
	_Camera_follow()

func _Camera_follow() -> void:
	_camera_controller.position = lerp(_camera_controller.position,%Character.position,0.12)
