extends HBoxContainer

const PlayerScore := preload("res://scriptable_objects/objects/PlayerScore.tres")

onready var ScoreLabel : Label = $Score
onready var TopScoreLabel : Label = $TopScore

func _ready() -> void:
	PlayerScore.connect("value_changed", self, "_on_PlayerScore_value_changed")

func _on_PlayerScore_value_changed() -> void:
	ScoreLabel.value = PlayerScore.value