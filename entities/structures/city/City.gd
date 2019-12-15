extends Node2D

func can_target() -> bool:
	return $Sprite.frame == 0

func take_damage() -> void:
	$Sprite.frame = 1
