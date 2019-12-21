extends Node2D

const EXPLOSION := preload("res://entities/explosion/Explosion.tscn")

onready var _parent_of_owner := owner.get_parent()

func _exit_tree() -> void:
	_explode()

func _explode() -> void:
	var explosion = EXPLOSION.instance()
	explosion.position = global_position
	_parent_of_owner.add_child(explosion)