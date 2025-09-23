extends RigidBody3D

@export_group("Movement")
@export var thrust_force:float = 10.0
@export var break_force:float = 0.05
@export var rotation_speed:float = 25.0
@export var max_speed:float = 5.0


func _physics_process(delta: float) -> void:
	_movement(delta)
	if Input.is_action_pressed("space_shoot") and $Bullet_Shoot_Timer.is_stopped():
		_shoot()

func _movement(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		apply_central_force((transform.basis * Vector3(0,0,-1) * thrust_force))
	if Input.is_action_pressed("left"):
		apply_torque(Vector3(0,1,0) * rotation_speed * delta)
	if Input.is_action_pressed("right"):
		apply_torque(Vector3(0,-1,0) * rotation_speed * delta)
	if Input.is_action_pressed("backward"):
		if linear_velocity.length() > 0.1:
			var break_dir = -linear_velocity.normalized()
			apply_central_force(break_dir * break_force)
		else:
			linear_velocity = Vector3.ZERO

	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

func _shoot() -> void:
	var bullet = preload("res://Demos/Space_shooter/Scenes/Bullet/bullet.tscn")
	var bullet_instance = bullet.instantiate()
	%Marker3D.add_child(bullet_instance)
	bullet_instance.transform = %Marker3D.global_transform
	
	$Bullet_Shoot_Timer.start()


func _on_hurt_box_area_entered(area: Area3D) -> void:
	print("Ship damaged")
