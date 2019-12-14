extends Node2D

signal goal_reached()

export (float) var goal : float

var _distance_travelled : float
onready var _previous_position : Vector2 = global_position

func _physics_process(delta):
	_update_distance_travelled()
	_update_previous_position()
	_check_for_goal()

func _update_distance_travelled() -> void:
	var displacement = (global_position - _previous_position).length()
	_distance_travelled += displacement

func _update_previous_position() -> void:
	_previous_position = global_position

func _check_for_goal() -> void:
	if _distance_travelled >= goal:
		emit_signal("goal_reached")