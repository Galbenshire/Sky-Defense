tool
extends Node2D

enum CONTROL_MODE {
	WITH_KEYS,
	WITH_MOUSE
}

signal position_emitted(event, position)

export (float) var move_speed : float = 200.0
export (Vector2) var boundary : Vector2 setget set_boundary
export (CONTROL_MODE) var control_mode : int = CONTROL_MODE.WITH_KEYS

var _start_position : Vector2

func _ready() -> void:
	_start_position = position

func _draw() -> void:
	if Engine.editor_hint:
		_draw_boundary()

func _unhandled_input(event : InputEvent) -> void:
	if !event is InputEventKey and !event is InputEventJoypadButton:
		return
	
	emit_signal("position_emitted", event, global_position)

func _physics_process(delta : float):
	if Engine.editor_hint:
		return
	
	_move_cursor(delta)
	_clamp_cursor()

func set_boundary(size : Vector2) -> void:
	boundary = size
	update()

func _move_cursor(delta : float) -> void:
	if control_mode == CONTROL_MODE.WITH_KEYS:
		_move_cursor_with_keys(delta)
	else:
		_move_cursor_with_mouse()

func _move_cursor_with_keys(delta : float) -> void:
	var velocity = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
			int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))).normalized()
	velocity *= move_speed
	
	position += velocity * delta

func _move_cursor_with_mouse() -> void:
	position = get_global_mouse_position()

func _clamp_cursor() -> void:
	position.x = clamp(position.x, _start_position.x - boundary.x, _start_position.x + boundary.x)
	position.y = clamp(position.y, _start_position.y - boundary.y, _start_position.y + boundary.y)

func _draw_boundary() -> void:
	var boundary_rect = Rect2(-boundary, boundary * 2)
	draw_rect(boundary_rect, Color.white, false)