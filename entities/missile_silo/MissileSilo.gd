extends Node2D

onready var AmmoCount : Label = $AmmoCount

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
	pass

func update_ammout_count_label() -> void:
	AmmoCount.text = str(missile_count)

func _shoot() -> void:
	print("%s is shooting" % str(name))
	self.missile_count -= 1

func _can_shoot(event : InputEvent) -> bool:
	return missile_count > 0 and event.is_action_pressed(input_action)

func _on_PlayerCursor_position_emitted(event : InputEvent, cursor_position : Vector2) -> void:
	if _can_shoot(event):
		_shoot()