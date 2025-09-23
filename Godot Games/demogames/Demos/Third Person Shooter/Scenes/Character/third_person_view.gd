extends Node3D

@export_group("Camera Rotation")
@export_range(0.00,1.0) var mouse_sensitivity = 0.03
@export var max_tilt_limit = deg_to_rad(60.0)
@export var min_tilt_limit = deg_to_rad(30.0)

@export_group("Player Movement")
@export var character_speed:float = 5.0 
@export var character_acc:float = 13.0
@export var rotation_speed:float = 20.0
@export var gravity_weight:float = 290.0

@onready var camera:Camera3D = %Camera3D
@onready var camera_pivot :=  %cameraPivot
@onready var player_character:CharacterBody3D = $Player_CharacterBody
@onready var player_skin := $Player_CharacterBody/skin
@onready var camera_spring := %RearSpringArm

const character_node = preload("res://Demos/Third Person Shooter/Scenes/Character/player_character_body.gd")

var is_aiming := false

var _camera_direction := Vector2.ZERO
var _last_move_dir := Vector3.RIGHT

func _unhandled_input(event: InputEvent) -> void:
# Move Camera around Player
	var is_camera_motion := (event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED)
	if is_camera_motion:
		_camera_direction = event.screen_relative * mouse_sensitivity
	
	if Input.is_action_just_pressed("aim"):
		is_aiming = true
		#player_skin.rotation_degrees.y -= event.relative.x * 0.06
		#player_skin.global_rotation.y  = Vector3.FORWARD.signed_angle_to(-camera.global_basis.z,Vector3.UP)
	if Input.is_action_just_released("aim"):
		is_aiming = false

# Camera Zoom
	if event is InputEventMouseButton:
		var spring_length = camera_spring.get_length()
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			camera_spring.set_length(spring_length - 1)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			camera_spring.set_length(spring_length + 1)

func _physics_process(delta: float) -> void:
	_camera_motion()
	_player_movement(delta)
	# Camera Follow Character
	#camera_spring.global_position = lerp(camera_spring.global_position,%CameraTarget.global_position,0.6 )
	

func _camera_motion():
	camera_pivot.global_rotation.x -= _camera_direction.y * mouse_sensitivity
	# Limit camera x  rotation
	camera_pivot.global_rotation.x  = clampf(camera_pivot.rotation.x,-min_tilt_limit,max_tilt_limit)
	camera_pivot.global_rotation.y -= _camera_direction.x * mouse_sensitivity
	_camera_direction= Vector2.ZERO

func _player_movement(delta: float) -> void:
	var input_dir := Input.get_vector("left","right","forward","backward")
	var direction := (transform.basis * Vector3(input_dir.x,0,input_dir.y).normalized())
	var forward := camera.global_basis.z
	var right := camera.global_basis.x

	var move_direction := forward * input_dir.y + right * input_dir.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	player_character.velocity = player_character.velocity.move_toward(move_direction * character_speed,character_acc)
	
	#Gravity Application
	if not player_character.is_on_floor():
		player_character.velocity.y -= gravity_weight * delta
	
	player_character.move_and_slide()
	
	if is_aiming:
		var camera_forward := -camera.global_basis.z
		var target_angle := Vector3.FORWARD.signed_angle_to(camera_forward,Vector3.UP)
		_last_move_dir = camera_forward
		player_skin.global_rotation.y = lerp_angle(player_skin.global_rotation.y,target_angle,rotation_speed * delta)
	else:
		if move_direction.length() > 0.2:
			_last_move_dir = move_direction
		var target_angle := Vector3.FORWARD.signed_angle_to(_last_move_dir,Vector3.UP)
		player_skin.global_rotation.y = target_angle #lerp_angle(player_skin.rotation.y, target_angle, rotation_speed * delta)
		#player_character.global_rotation.y = target_angle
