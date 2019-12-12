extends Node2D

signal missile_angle_update_requested(self_ref)

onready var MissileSpawn : Position2D = $MissileSpawn
onready var AmmoCount : Label = $AmmoCount

export (int, 1, 32) var max_missile_ammo : int = 15

const MISSILE := preload("res://entities/player_missile/PlayerMissile.tscn")

var last_missile_angle : float = -PI/2.0

var _missile_ammo : int

func _ready() -> void:
	reset()

func _unhandled_input(event : InputEvent) -> void:
	_handle_missile_fire_input(event)

func reset() -> void:
	_missile_ammo = max_missile_ammo

func _handle_missile_fire_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and _can_fire_missile():
		_fire_missile()
		_missile_ammo -= 1
		_update_ammo_count_label()

func _fire_missile() -> void:
	var missile = MISSILE.instance()
	missile.set_move_direction(last_missile_angle)
	missile.global_position = MissileSpawn.global_position
	missile.set_move_direction(_generate_missile_angle())
	get_parent().add_child(missile)

func _generate_missile_angle() -> float:
	emit_signal("missile_angle_update_requested", self)
	return last_missile_angle

func _can_fire_missile() -> bool:
	return _missile_ammo > 0

func _update_ammo_count_label() -> void:
	AmmoCount.text = str(_missile_ammo)