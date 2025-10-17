extends Area3D

const SPEED = 14.0
const RANGE = 50.0

var traveled_distance = 0.0

func _process(delta: float) -> void:
	position += -transform.basis.z * SPEED * delta
	traveled_distance += SPEED * delta
	if traveled_distance > RANGE:
		queue_free()
