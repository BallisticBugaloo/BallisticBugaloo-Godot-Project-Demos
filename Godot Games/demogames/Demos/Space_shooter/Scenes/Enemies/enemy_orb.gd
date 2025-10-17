extends Area3D

@export var orb_speed := 20.0

@onready var player_ship:RigidBody3D = get_tree().get_first_node_in_group("ship")

func _physics_process(delta: float) -> void:
	if player_ship == null:
		return
	
	look_at(player_ship.global_transform.origin,Vector3.UP)
	
	position = player_ship.global_position - global_position


func _on_area_entered(area: Area3D) -> void:
	queue_free()
