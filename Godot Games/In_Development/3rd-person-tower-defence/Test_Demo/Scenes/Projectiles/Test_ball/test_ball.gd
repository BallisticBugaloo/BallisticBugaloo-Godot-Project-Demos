extends Area3D

@export var SPEED = 50.0
const range_limit = 40.0
var range_distance = 0.0

func _process(delta: float) -> void:
	# Moves ball based on speed and transform
	position += -transform.basis.z * SPEED * delta
	range_distance += SPEED * delta
	if range_distance > range_limit:
		queue_free()
