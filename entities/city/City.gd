extends Node2D

onready var CitySprite : Sprite = $Sprite

func can_target() -> bool:
	return !is_destroyed()

func take_damage_from_missile() -> void:
	CitySprite.frame = 1

func is_destroyed() -> bool:
	return CitySprite.frame == 1