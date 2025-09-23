extends Area3D

var bullet_speed:float = 20.0
var bullet_range:float = 200.0

func _physics_process(delta: float) -> void:
	position -= transform.basis.z * bullet_speed * delta
	
	if position.z > bullet_range:
		queue_free()
