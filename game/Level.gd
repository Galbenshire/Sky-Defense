extends Node

onready var MissileSpawner : Node2D = $Entities/MissileSpawner
onready var PlayerCursor : Node2D = $Entities/PlayerCursor
onready var LevelStart : Label = $HUD/LevelStart

func _ready() -> void:
	PlayerCursor.enabled = false
	yield(get_tree().create_timer(3.0), "timeout")
	PlayerCursor.enabled = true
	MissileSpawner.spawn_missiles()
	LevelStart.hide()