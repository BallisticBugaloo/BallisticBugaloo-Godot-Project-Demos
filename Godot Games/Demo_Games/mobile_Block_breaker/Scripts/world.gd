extends Node2D

var green_brick = preload("res://Scenes/Green_brick.tscn")

@export var brick = preload("res://Scenes/Green_brick.tscn")

@onready var brick_container = $Brick_Container
@onready var brick_spawner = $Brick_spawner

var level:int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && level > 0:
		#Spawns the number of bricks according to the level
		for i in range(level):
			brickSpawn()
		#increases the level every time a brick is spawned
		level += 1

func brickSpawn():
	var brick_instance = green_brick.instantiate()
	var spawns = brick_spawner.get_children()
	var index = randi() % spawns.size()
	brick_container.add_child(brick_instance)
	brick_instance.global_position = spawns[index].global_position
	print("brick spawned")
