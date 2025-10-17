extends Node

@export var pipe_scene : PackedScene

var game_running: bool
var game_over: bool
var scroll
var score
const scroll_speed: int = 4
var screen_size: Vector2i
var ground_height: int
var pipes: Array
const pipe_delay: int = 100
const pipe_range: int = 200

func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$ScoreLabel.text = "SCORE: " + str(score)
	$GameOver.hide()
	get_tree().call_group("pipes","queue_free")
	pipes.clear()
	generate_pipes()
	$Bird.reset()

func _input(event):
	if game_over == false:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_SPACE:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()

func _process(delta):
	if game_running:
		scroll += scroll_speed
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= scroll_speed


func _on_timer_timeout():
	generate_pipes()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + pipe_delay
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-pipe_range, pipe_range)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func scored():
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)

func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true

func bird_hit():
	$Bird.falling = true
	stop_game()

func _on_ground_hit():
	$Bird.falling = false
	stop_game()


func _on_game_over_restart():
	new_game()
