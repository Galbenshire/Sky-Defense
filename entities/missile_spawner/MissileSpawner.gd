tool
extends Node2D

const MISSILE := preload("res://entities/projectiles/enemy_missile/EnemyMissile.tscn")

export (float, 0, 128) var x_range : float setget set_x_range

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
	missile.global_position = position + Vector2(rand_range(-x_range, x_range), 0)
	missile.speed = 20.0
	missile.direction = Vector2.DOWN
	get_parent().add_child(missile)

func _on_SpawnRate_timeout() -> void:
	_spawn_missile()
