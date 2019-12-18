tool
extends Resource
class_name MissileSpawningLimits

export (int, 1, 32) var total_missiles : int = 12 setget set_total_missiles
export (int, 1, 32) var max_missiles_on_screen : int = 4 setget set_max_missiles_on_screen
export (int, 1, 32) var minimum_missile_threshold : int = 2 setget set_minimum_missile_threshold

func set_total_missiles(value : int) -> void:
	total_missiles = value
	set_max_missiles_on_screen(int(min(value, max_missiles_on_screen)))

func set_max_missiles_on_screen(value : int) -> void:
	if value <= total_missiles:
		max_missiles_on_screen = value
		set_minimum_missile_threshold(int(min(value, minimum_missile_threshold)))
	else:
		printerr("Warning: 'max_missiles_on_screen' cannot exceed 'total_missiles'")

func set_minimum_missile_threshold(value : int) -> void:
	if value <= max_missiles_on_screen:
		minimum_missile_threshold = value
	else:
		printerr("Warning: 'minimum_missile_threshold' cannot exceed 'max_missiles_on_screen'")
