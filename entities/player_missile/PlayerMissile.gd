extends Node2D

export (float) var move_speed : float = 100.0
export (float) var distance_to_travel : float = 200.0

var _velocity : Vector2

func _physics_process(delta : float) -> void:
	_move_missile(delta)
	_update_distance_to_travel(delta)

func set_move_direction(angle : float) -> void:
	_velocity = Vector2.RIGHT * move_speed
	_velocity = _velocity.rotated(angle)

func _move_missile(delta : float) -> void:
	position += _velocity * delta

func _update_distance_to_travel(delta : float) -> void:
	distance_to_travel -= _velocity.length() * delta
	
	if distance_to_travel <= 0.0:
		_explode()

func _explode() -> void:
	queue_free()