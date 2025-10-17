extends Character

@export var acceleration:float = 8.0
@export var deceleration:float = 4.0

@onready var camera: Camera3D = $CameraController/Camera3D
@onready var skin: Node3D = $playerSkin

func _process(delta: float) -> void:
	move_logic(delta)
	move_and_slide()

func _physics_process(delta: float) -> void:
	move_logic(delta)
	move_and_slide()

func move_logic(delta: float) -> void:
	movement_input = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	print(movement_input)
	if movement_input != Vector2.ZERO:
		vel_2d += movement_input * base_speed * delta * acceleration
		vel_2d = vel_2d.limit_length(base_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		var target_angle = movement_input.angle() + PI/2
		skin.rotation.y = rotate_toward(skin.rotation.y, target_angle, delta * 6)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO,base_speed * delta * deceleration)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
