extends Node

signal end_reached()

onready var CheckRate : Timer = $CheckRate

var enabled : bool = false setget set_enabled

func set_enabled(value : bool) -> void:
	if enabled == value:
		return
	
	enabled = value
	
	if enabled:
		CheckRate.start()
	else:
		CheckRate.stop()

func _are_missiles_and_explosions_present() -> bool:
	var missile_count = get_tree().get_nodes_in_group("projectile").size()
	var explosion_count = get_tree().get_nodes_in_group("explosion").size()
	
	return missile_count + explosion_count > 0

func _on_CheckRate_timeout() -> void:
	if !_are_missiles_and_explosions_present():
		emit_signal("end_reached")
		set_enabled(false)
