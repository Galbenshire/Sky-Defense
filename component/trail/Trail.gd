extends Node2D

export (Color) var color : Color = Color8(81, 130, 255)

var _start_position : Vector2

func _ready():
	_start_position = global_position

func _draw():
	draw_line(Vector2(), to_local(_start_position), color)

func _process(delta):
	update()
