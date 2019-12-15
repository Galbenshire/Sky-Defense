extends Node2D

onready var MissileSpawn : Position2D = $MissileSpawn

export (int, 1, 32) var max_missile_ammo : int = 15
export (String) var fire_action : String

const MISSILE := preload("res://entities/missiles/player_missile/PlayerMissile.tscn")

var _missile_ammo : int setget set_missile_ammo

func _ready() -> void:
	_assert_valid_fire_action()
	reset()

func set_missile_ammo(value : int) -> void:
	_missile_ammo = int(max(value, 0))
	_update_ammo_count_label()

func reset() -> void:
	set_missile_ammo(max_missile_ammo)

func can_target() -> bool:
	return true

func take_damage() -> void:
	self._missile_ammo -= 7

func _fire_missile(target_position : Vector2) -> void:
	var missile = MISSILE.instance()
	missile.global_position = MissileSpawn.global_position
	missile.set_move_direction(target_position.angle_to_point(MissileSpawn.global_position))
	get_parent().add_child(missile)
	missile.DistanceGoal.goal = (MissileSpawn.global_position - target_position).length()

func _can_fire_missile() -> bool:
	return _missile_ammo > 0

func _update_ammo_count_label() -> void:
	$AmmoCount.text = str(_missile_ammo)

func _assert_valid_fire_action() -> void:
	assert(!fire_action.empty() and InputMap.has_action(fire_action))

func _on_target_position_received(event : InputEvent, target_position : Vector2) -> void:
	if event.is_action_pressed(fire_action) and _can_fire_missile():
		_fire_missile(target_position)
		self._missile_ammo -= 1