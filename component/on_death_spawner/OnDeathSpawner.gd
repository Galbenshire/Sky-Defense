extends Node2D

export (PackedScene) var scene : PackedScene

onready var _parent_of_owner : Node = owner.get_parent()

func _exit_tree() -> void:
	_spawn()

func _spawn() -> void:
	var instance = scene.instance()
	instance.global_position = global_position
	_parent_of_owner.add_child(instance)