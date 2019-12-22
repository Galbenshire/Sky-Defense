tool
extends Node2D

signal all_missiles_gone()

const MISSILE := preload("res://entities/projectiles/enemy_missile/EnemyMissile.tscn")

export (Resource) var missile_settings : Resource setget set_missile_settings
export (float, 0, 128) var x_range : float setget set_x_range

var _missiles_left : int

func _draw() -> void:
	if Engine.editor_hint:
		draw_line(Vector2(-x_range, 0), Vector2(x_range, 0), Color.white)
		_draw_line_end(-x_range, 4)
		_draw_line_end(x_range, 4)

func _get_configuration_warning() -> String:
	if !_is_missile_settings_valid():
		return "Please set 'Missile Settings' with a LevelSettings resource"
	
	return ""

func set_missile_settings(resource : Resource) -> void:
	missile_settings = resource
	if _is_missile_settings_valid():
		_missiles_left = missile_settings.missile_count

func set_x_range(value : float) -> void:
	x_range = value
	update()

func spawn_missiles() -> void:
	assert(_is_missile_settings_valid())
	
	if _missiles_left <= 0:
		return
	
	var missiles_to_spawn = _determine_spawn_missile_count()
	
	for m in range(missiles_to_spawn):
		_spawn_missile()
		_missiles_left -= 1

func _determine_spawn_missile_count() -> int:
	var high_range = int(min(missile_settings.max_missiles_on_screen, _missiles_left))
	var low_range = int(min(missile_settings.minimum_missile_threshold, high_range))
	var random_part = 0 if (high_range - low_range) == 0 else randi() % (high_range - low_range)
	
	return low_range + random_part

func _spawn_missile() -> void:
	var missile = MISSILE.instance()
	missile.global_position = position + Vector2(rand_range(-x_range, x_range), 0)
	missile.speed = missile_settings.missile_speed
	missile.direction = Vector2.DOWN
	get_parent().add_child(missile)
	missile.connect("tree_exited", self, "_on_missile_blew_up")

func _draw_line_end(x_start : float, half_height : float) -> void:
	draw_line(Vector2(x_start, half_height), Vector2(x_start, -half_height), Color.white)

func _is_missile_settings_valid() -> bool:
	return missile_settings is LevelSettings

func _on_missile_blew_up() -> void:
	var missiles_on_screen = get_tree().get_nodes_in_group("enemy_missile").size()
	
	if _missiles_left > 0:
		if missiles_on_screen < missile_settings.minimum_missile_threshold:
			spawn_missiles()
	else:
		if missiles_on_screen <= 0:
			emit_signal("all_missiles_gone")