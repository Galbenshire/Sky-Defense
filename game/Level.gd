extends Node

onready var LevelEndChecker : Node = $LevelEndChecker
onready var MissileSpawner : Node2D = $Entities/MissileSpawner
onready var PlayerCursor : Node2D = $Entities/PlayerCursor
onready var LevelStart : Label = $HUD/LevelStart
onready var LevelEnd : Label = $HUD/LevelEnd
onready var CitiesSaved : Label = $HUD/CitiesSaved

func _ready() -> void:
	print(get_instance_id())
	PlayerCursor.enabled = false
	yield(get_tree().create_timer(3.0), "timeout")
	PlayerCursor.enabled = true
	MissileSpawner.spawn_missiles()
	LevelStart.hide()

func _level_end() -> void:
	LevelEnd.show()
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	var city_count = _get_intact_city_count()
	CitiesSaved.text = "%d CITIES SAVED" % city_count
	CitiesSaved.show()
	
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().reload_current_scene()

func _get_intact_city_count() -> int:
	var cities = get_tree().get_nodes_in_group("city")
	var intact_city_count = 0
	
	for city in cities:
		if !city.is_destroyed():
			intact_city_count += 1
	
	return intact_city_count

func _on_MissileSpawner_all_missiles_gone() -> void:
	PlayerCursor.enabled = false
	LevelEndChecker.enabled = true

func _on_LevelEndChecker_end_reached() -> void:
	_level_end()
