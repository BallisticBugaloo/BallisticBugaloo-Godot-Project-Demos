extends SpringArm3D

@export var min_limit_x :float = -1.1
@export var max_limit_x :float = 0.2
@export var horizontal_acc:float = 0.02
@export var vertical_acc:float = 0.01
@export var mouse_acc:float = 0.005

#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_right", "pan_left", "pan_down", "pan_up")
	var joy_dir_acc = joy_dir * Vector2(horizontal_acc, vertical_acc)
	rotate_from_vector(joy_dir_acc)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if (event as InputEventKey).keycode == KEY_ALT:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_dir_acc = event.relative * mouse_acc
		rotate_from_vector(mouse_dir_acc)

func rotate_from_vector(v:Vector2) -> void:
	if v.length() == 0: return
	rotation.y -= v.x
	rotation.x -= v.y
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x)
