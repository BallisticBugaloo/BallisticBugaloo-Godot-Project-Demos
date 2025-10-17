extends CharacterBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.5
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 70.0)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseButton and event.is_pressed() and not event.is_echo():
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	const SPEED = 5.0
	const jump_height = 10.0
	var input_dir_2d = Input.get_vector("moveLeft","moveRight","moveForward","moveBack")
	var input_dir_3d = Vector3(input_dir_2d.x,0.0,input_dir_2d.y)
	var direction = transform.basis * input_dir_3d
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_height
	elif Input.is_action_just_released("ui_accept") and velocity.y > 0.0:
		velocity.y = 0.0
	
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		_shoot_bullet()
	

func _shoot_bullet() -> void:
	const BULLET_3D = preload("res://player/projectile/Bullet3D.tscn")
	var Bullet_instance = BULLET_3D.instantiate()
	%Marker3D.add_child(Bullet_instance)
	
	Bullet_instance.global_transform = %Marker3D.global_transform
	%Timer.start()
