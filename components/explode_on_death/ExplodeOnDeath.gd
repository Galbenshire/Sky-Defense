extends Node2D

onready var parent_of_owner := owner.get_parent()

func _exit_tree() -> void:
	print("Explode!")