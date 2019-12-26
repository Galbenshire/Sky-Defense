extends Resource
class_name ScriptableInt

signal value_changed()

export (int) var value : int = 0 setget set_value

func set_value(new_value : int) -> void:
	value = new_value
	emit_signal("value_changed")