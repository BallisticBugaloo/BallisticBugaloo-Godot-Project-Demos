extends RigidBody3D

@export_group("Movement")
@export var move_speed: int = 15

@export_group("Projectiles")
@export var projectile :PackedScene
@export var base_ammo := 5.0
var bullet_ammo := 0.0
var spawn_delay := 0.6
var time_since_last_spawn := 0.0

@onready var _skin: Node3D = %Skin
@onready var _camera_controller: Node3D = $CameraController

func _ready() -> void:
	bullet_ammo += base_ammo

func _unhandled_input(event: InputEvent) -> void:
	_click_focus(event)

func _physics_process(delta: float) -> void:
	_movement(delta)
	_body_rotation()
	if Input.is_action_pressed("shoot"):
		time_since_last_spawn += delta
		if time_since_last_spawn >= spawn_delay:
			_Bullet_Burst()
			time_since_last_spawn = 0.0
	else:
		time_since_last_spawn = 0.0

func _click_focus(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if(event as InputEvent).keycode == KEY_ALT:
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _movement(delta) -> void:
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var move_direction := Vector3(raw_input.x,0,raw_input.y)
	var force := move_direction * move_speed
	if move_direction.length() > 0:
		move_direction.normalized()
		apply_central_force(force)
		var target_direction := Vector3.FORWARD.signed_angle_to(move_direction * delta, Vector3.UP)
		_skin.global_rotation.y = target_direction
		
		#_last_move_diretion = move_direction
		#var target_direction := Vector3.FORWARD.signed_angle_to(_last_move_diretion, Vector3.UP)
		#_skin.global_rotation.y = target_direction

# Top Down Control
func _body_rotation() -> void:
	var raw_input := Input.get_vector("camera_move_left", "camera_move_right", "camera_move_up", "camera_move_down")
	var face_direction := Vector3(raw_input.x,0,raw_input.y)
	if face_direction.length() > 0:
		face_direction.normalized()
		var target_direction := Vector3.FORWARD.signed_angle_to(face_direction, Vector3.UP)
		_skin.global_rotation.y = target_direction

# Projectile Spawn
func _projectile_spawn() -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.position = %pos_projectile.global_position
	projectile_instance.transform.basis = %pos_projectile.global_transform.basis
	%pos_projectile.add_child(projectile_instance)

func _on_bullet_cooldown_timer_timeout() -> void:
	bullet_ammo += base_ammo
	_Bullet_Burst()

func _Bullet_Burst() -> void:
	if bullet_ammo > 0:
		_projectile_spawn()
		bullet_ammo -= 1.0
	else:
		bullet_ammo += base_ammo
