tool
extends Node2D

const MISSILE := preload("res://entities/missiles/enemy_missile/EnemyMissile.tscn")

export (Resource) var spawning_limits : Resource
export (float, 0, 128) var x_range : float setget set_x_range

var _targets : Array = []
var _missiles_left : int

func _ready() -> void:
	if !Engine.editor_hint:
		assert(spawning_limits is MissileSpawningLimits)
		call_deferred("reset")
		yield(get_tree().create_timer(3.0), "timeout")
		_spawn_missiles()

func _draw() -> void:
	if Engine.editor_hint:
		draw_line(Vector2(-x_range, 0), Vector2(x_range, 0), Color.white)
		_draw_line_end(-x_range, 4)
		_draw_line_end(x_range, 4)

func set_x_range(value : float) -> void:
	x_range = value
	update()

func reset() -> void:
	_missiles_left = spawning_limits.total_missiles
	_update_target_list()

func _draw_line_end(x_start : float, half_height : float) -> void:
	draw_line(Vector2(x_start, half_height), Vector2(x_start, -half_height), Color.white)

func _update_target_list() -> void:
	var full_list = get_tree().get_nodes_in_group("structure")
	_targets.clear()
	
	for node in full_list:
		if node.can_target():
			_targets.append(node)

func _spawn_missiles() -> void:
	if _missiles_left <= 0:
		return
	
	var missiles_to_spawn = _determine_spawn_missile_count()
	
	for m in range(missiles_to_spawn):
		_spawn_missile()
		_missiles_left -= 1

func _spawn_missile() -> void:
	var missile = MISSILE.instance()
	_setup_missile(missile)
	get_parent().add_child(missile)
	missile.connect("tree_exited", self, "_on_missile_blew_up")

func _setup_missile(missile : Node2D) -> void:
	var spawn_position = global_position + Vector2(rand_range(-x_range, x_range), 0)

	missile.global_position = spawn_position
	missile.move_speed = 20.0
	missile.set_move_direction(_calculate_angle_to_target(spawn_position))

func _calculate_angle_to_target(missile_position : Vector2) -> float:
	var chosen_target = _targets[randi() % _targets.size()]
	return chosen_target.global_position.angle_to_point(missile_position)

func _determine_spawn_missile_count() -> int:
	var high_range = int(min(spawning_limits.max_missiles_on_screen, _missiles_left))
	var low_range = int(min(spawning_limits.minimum_missile_threshold, high_range))
	var random_part = 0 if (high_range - low_range) == 0 else randi() % (high_range - low_range)
	
	return low_range + random_part

func _on_missile_blew_up() -> void:
	var missiles_on_screen = get_tree().get_nodes_in_group("enemy_missile").size()
	if missiles_on_screen < spawning_limits.minimum_missile_threshold:
		_spawn_missiles()