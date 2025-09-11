extends CharacterBody3D

@export var speed = 2.0
@export var attack_range = 5.0

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	look_at(player.global_transform.origin, Vector3.UP)
	
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	 
	velocity = dir * speed
	move_and_slide()


func _on_hurt_box_area_entered(area: Area3D) -> void:
	var dir = player.global_position - global_position
	velocity -= dir * 2.0
	move_and_slide()
	print("Enemy  HIT")
