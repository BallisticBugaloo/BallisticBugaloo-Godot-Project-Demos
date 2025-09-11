extends Area3D

@export var bullet_speed:int = 120
var bullet_range:int = 2000

func _physics_process(delta: float) -> void:
	position -= transform.basis.z * bullet_speed * delta
	
	if position.x > bullet_range:
		queue_free()
