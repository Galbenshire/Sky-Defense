extends Resource
class_name ScriptableFloat

signal value_changed()

export (float) var value : float = 0.0

func set_value(new_value : float) -> void:
	value = new_value
	emit_signal("value_changed")