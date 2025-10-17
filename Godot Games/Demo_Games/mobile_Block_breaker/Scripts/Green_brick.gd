extends CharacterBody2D

var level:int = 1
var move_per_level:int = 0
var down_mv_speed:int = 5

#func _ready():
	#move_block()

func _physics_process(delta):
	move_block()

func move_block():
	position += transform.y * down_mv_speed
	#position = position + transform.y * 5
	#velocity.y = global_position.y + down_mv_speed
func _on_area_2d_area_exited(area):
	queue_free()


