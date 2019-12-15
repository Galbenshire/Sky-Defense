extends "res://entities/missiles/_base/Missile.gd"

func _on_Hitbox_area_entered(area : Area2D) -> void:
	area.get_parent().take_damage()
	queue_free()
