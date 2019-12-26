extends Node

const PlayerScore := preload("res://scriptable_objects/objects/PlayerScore.tres")

export (int) var value : int = 100

func _exit_tree() -> void:
	PlayerScore.value += value
	print("You have gained %d points. You now have %d points." % [value, PlayerScore.value])