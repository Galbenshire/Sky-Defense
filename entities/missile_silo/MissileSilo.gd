extends Node2D

onready var MissileSpawn : Position2D = $MissileSpawn
onready var AmmoCount : Label = $AmmoCount

const MISSILE := preload("res://entities/projectiles/player_missile/PlayerMissile.tscn")

export (String) var input_action : String

var missile_count : int = 15 setget set_missile_count

func _ready() -> void:
	assert(InputMap.has_action(input_action))
	update_ammout_count_label()

func set_missile_count(value : int) -> void:
	missile_count = int(max(0, value))
	update_ammout_count_label()

func can_target() -> bool:
	return true

func take_damage_from_missile() -> void:
	self.missile_count -= 7

func update_ammout_count_label() -> void:
	AmmoCount.value = missile_count

func _shoot_missile(target_position : Vector2) -> void:
	var missile = MISSILE.instance()
	missile.global_position = MissileSpawn.global_position
	missile.speed = 150.0
	missile.direction = MissileSpawn.global_position.direction_to(target_position)
	get_parent().add_child(missile)
	missile.DistanceGoal.goal = (MissileSpawn.global_position - target_position).length()

func _can_shoot(event : InputEvent) -> bool:
	return missile_count > 0 and event.is_action_pressed(input_action)

func _on_PlayerCursor_position_emitted(event : InputEvent, cursor_position : Vector2) -> void:
	if _can_shoot(event):
		_shoot_missile(cursor_position)
		self.missile_count -= 1