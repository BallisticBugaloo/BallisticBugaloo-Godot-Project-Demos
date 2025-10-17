extends Node2D

var from_center: Vector2 = Vector2(576.0, 270.0)
var screen_center: Vector2
var end_point: Vector2 = Vector2(0, -50)
var time = 0.0

const circle_radius: float = 50.0
const circle_color: Color = Color.DIM_GRAY

func _ready() -> void:
	get_screen_center()

func get_screen_center():
	screen_center = get_viewport().size / 2
	print(screen_center)

func _draw() -> void:
	draw_circle(screen_center, circle_radius, circle_color, true, 0.0, true)
	draw_line(from_center,screen_center + end_point, Color.RED, 5.0, true)

func _process(delta: float) -> void:
    time += delta
    end_point = circle_radius * Vector2(cos(time), sin(time))
    queue_redraw()