extends "res://entities/projectiles/_base/Projectile.gd"

func _on_Hitbox_area_entered(area : Area2D) -> void:
	area.owner.take_damage_from_missile()
	queue_free()

func _on_StructureTargetter_target_acquired(target_position : Vector2) -> void:
	direction = global_position.direction_to(target_position)
