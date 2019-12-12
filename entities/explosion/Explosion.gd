extends Node2D

export (float) var radius : float setget set_radius

func _ready() -> void:
	_build_explosion_tween()
	$ExplodeTween.start()

func _draw() -> void:
	draw_circle(Vector2(), radius, Color.white)

func set_radius(value : float) -> void:
	radius = value
	update()

func _build_explosion_tween() -> void:
	$ExplodeTween.interpolate_property(self, "radius", 0.0, 16.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ExplodeTween.interpolate_property(self, "radius", 16.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.0)
	$ExplodeTween.interpolate_callback(self, 2.0, "queue_free")
