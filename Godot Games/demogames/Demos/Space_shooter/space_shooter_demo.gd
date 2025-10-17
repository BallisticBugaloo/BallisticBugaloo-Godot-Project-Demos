extends Node3D

@onready var ingame_Mintues := $ingame_UI/InGameTimer/Mintues
@onready var ingame_Seconds := $ingame_UI/InGameTimer/Seconds

var Minutes:int = 0
var Seconds:int = 0

func _ready() -> void:
	#$Enemies/Timer.start()
	pass

func _physics_process(delta: float) -> void:
	
	if Seconds >= 60:
		Minutes += 1
		ingame_Mintues.text = str(Minutes) + " : " 
		Seconds = 0

	if $Enemies/Timer.is_stopped():
		enemy_spawn()

func _on_timer_timeout() -> void:
	Seconds += 1
	ingame_Seconds.text = str(Seconds)

func enemy_spawn():
	var enemy_orb = preload("res://Demos/Space_shooter/Scenes/Enemies/enemy_orb.tscn")
	var enemy_orb_instance := enemy_orb.instantiate()
	var enemy_pos = $top_down_view/Space_ship.position * 2
	add_child(enemy_orb_instance)
	enemy_orb_instance.position = enemy_pos
	$Enemies/Timer.start()
