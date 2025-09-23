extends CharacterBody3D

@export var character_speed:float = 15.0
@export var character_acc:float = 13.0
@export var base_ammo:int = 5
var gun_ammo := base_ammo

@onready var _camera: Camera3D = get_tree().get_first_node_in_group("Player_Camera")

func _physics_process(delta: float) -> void:
	#char_move()
	
	if not is_on_floor():
		velocity.y -= 5
	
	shoot_bullet()

func char_move():
	var input_dir := Input.get_vector("left","right","forward","backward")
	var direction := (transform.basis * Vector3(input_dir.x,0,input_dir.y).normalized())
	#if direction:
		#velocity.x = direction.x * character_speed
		#velocity.z = direction.z * character_speed
	#else:
		#velocity.x = move_toward(velocity.x,0,character_speed - 3)
		#velocity.z = move_toward(velocity.z,0,character_speed - 3)
		
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x

	var move_direction := forward * input_dir.y + right * input_dir.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	velocity = velocity.move_toward(move_direction * character_speed,character_acc)
	move_and_slide()

func bullet_shoot_instance() -> void:
	var bullet = preload("res://Demos/Third Person Shooter/Scenes/Bullet/bullet_character_body.tscn")
	var bullet_instance = bullet.instantiate()
	%Marker3D.add_child(bullet_instance)
	bullet_instance.transform = %Marker3D.global_transform
	
	$Burst_Timer.start()

func shoot_bullet() -> void:
	if Input.is_action_pressed("shoot") and $Burst_Timer.is_stopped():
		if gun_ammo > 0:
			bullet_shoot_instance()
			gun_ammo -= 1
		if $Reload_Timer.is_stopped():
			start_reload() 

func start_reload() -> void:
	if gun_ammo < 1:
		gun_ammo = base_ammo
	$Reload_Timer.start()


func _on_hurt_box_area_entered(area: Area3D) -> void:
	print("PLAYER HURT")
