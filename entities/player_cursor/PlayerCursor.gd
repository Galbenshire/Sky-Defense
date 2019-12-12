tool
extends Node2D

export (float) var move_speed : float = 200.0
export (Vector2) var boundary : Vector2 setget set_boundary

var _start_position : Vector2

func _ready() -> void:
	_start_position = position

func _draw() -> void:
	if Engine.editor_hint:
		_draw_boundary()

func _physics_process(delta : float):
	if Engine.editor_hint:
		return
	
	_move_cursor(delta)
	_clamp_cursor()

func set_boundary(size : Vector2) -> void:
	boundary = size
	update()

func _move_cursor(delta : float) -> void:
	var velocity = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
			int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))).normalized()
	velocity *= move_speed
	
	position += velocity * delta

func _clamp_cursor() -> void:
	position.x = clamp(position.x, _start_position.x - boundary.x, _start_position.x + boundary.x)
	position.y = clamp(position.y, _start_position.y - boundary.y, _start_position.y + boundary.y)

func _draw_boundary() -> void:
	var boundary_rect = Rect2(-boundary, boundary * 2)
	draw_rect(boundary_rect, Color.white, false)

func _on_angle_requested(missile_base : Node2D) -> void:
	pass