tool
extends Node2D

const MISSILE := preload("res://entities/missiles/enemy_missile/EnemyMissile.tscn")

export (int, 0, 32) var total_missiles : int
export (float, 0, 128) var x_range : float setget set_x_range

var _targets : Array = []

func _ready() -> void:
	if !Engine.editor_hint:
		call_deferred("_get_targets")

func _draw() -> void:
	if Engine.editor_hint:
		draw_line(Vector2(-x_range, 0), Vector2(x_range, 0), Color.white)
		_draw_line_end(-x_range, 4)
		_draw_line_end(x_range, 4)

func set_x_range(value : float) -> void:
	x_range = value
	update()

func _draw_line_end(x_start : float, half_height : float) -> void:
	draw_line(Vector2(x_start, half_height), Vector2(x_start, -half_height), Color.white)

func _spawn_missile() -> void:
	var missile = MISSILE.instance()
	_setup_missile(missile)
	get_parent().add_child(missile)

func _setup_missile(missile : Node2D) -> void:
	var spawn_position = global_position + Vector2(rand_range(-x_range, x_range), 0)
	
	missile.global_position = spawn_position
	missile.move_speed = 20.0
	missile.set_move_direction(_calculate_angle_to_target(spawn_position))

func _calculate_angle_to_target(missile_position : Vector2) -> float:
	var chosen_target = _targets[randi() % _targets.size()]
	return chosen_target.global_position.angle_to_point(missile_position)

func _get_targets() -> void:
	_targets = get_tree().get_nodes_in_group("structure")

func _on_SpawnRate_timeout() -> void:
	_spawn_missile()
