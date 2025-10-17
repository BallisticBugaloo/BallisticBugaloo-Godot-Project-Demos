extends CharacterBody2D

enum Cow_state {IDLE, WALK}

@export var move_speed: float = 20.0
@export var idle_time: float = 5.0
@export var walk_time: float = 2.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var move_direction: Vector2  = Vector2.ZERO
var current_state: Cow_state = Cow_state.IDLE

func _ready():
	pick_new_state()

func _physics_process(_delta):
	if(current_state == Cow_state.WALK):
		velocity = move_direction * move_speed
		
		move_and_slide()
#	print(Cow_state)

# Randomly generated a move direction
# can be either -1,0, or 1 for x and y
func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif(move_direction.x > 0):
		sprite.flip_h = false

# Switch from walking to idling
func pick_new_state():
	if(current_state == Cow_state.IDLE):
		# Change to Walk State
		state_machine.travel("Walk")
		current_state = Cow_state.WALK
		select_new_direction()
		timer.start(walk_time)
	elif(current_state == Cow_state.WALK):
		# Change to Idle State
		state_machine.travel("Idle")
		current_state = Cow_state.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	print(current_state," ",state_machine)
	pick_new_state()
