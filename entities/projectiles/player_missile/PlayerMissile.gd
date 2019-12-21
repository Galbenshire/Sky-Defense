extends "res://entities/projectiles/_base/Projectile.gd"

onready var DistanceGoal : Node2D = $DistanceGoal

func _on_DistanceGoal_goal_reached() -> void:
	queue_free()
