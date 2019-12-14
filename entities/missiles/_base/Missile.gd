extends Node2D

export (float) var move_speed : float = 100.0

var _velocity : Vector2

func _physics_process(delta : float) -> void:
	_move_missile(delta)

func set_move_direction(angle : float) -> void:
	_velocity = Vector2.RIGHT * move_speed
	_velocity = _velocity.rotated(angle)

func _move_missile(delta : float) -> void:
	position += _velocity * delta