tool
extends Label

export (int) var zero_pad_length : int setget set_zero_pad_length
export (int) var value : int setget set_value

var _format_string : String = "%00d"

func set_zero_pad_length(length : int) -> void:
	zero_pad_length = length
	_build_format_string()
	_update_label()

func set_value(new_value : int) -> void:
	value = new_value
	_update_label()

func _build_format_string() -> void:
	_format_string = str("%0", zero_pad_length, "d")

func _update_label() -> void:
	text = _format_string % value