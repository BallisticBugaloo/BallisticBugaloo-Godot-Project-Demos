extends Node3D

@export var ball : PackedScene


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var inst = ball.instantiate()
		owner.add_child(inst)
		inst.transform = %Marker3D.global_transform
