extends Node2D

onready var ExplodeRadius : CircleShape2D = $Hitbox/Collision.shape

var radius : float = 0.0 setget set_radius

func _ready() -> void:
	set_radius(0)
	_build_explosion_tween()
	$ExplodeTween.start()

func _draw() -> void:
	draw_circle(Vector2(), radius, Color.white)

func set_radius(value : float) -> void:
	radius = value
	_set_explode_radius()
	update()

func _set_explode_radius() -> void:
	if ExplodeRadius:
		ExplodeRadius.radius = radius

func _make_another_explosion(target_position) -> void:
	var copy = duplicate()
	copy.position = target_position
	copy.radius = 0
	get_parent().add_child(copy)

func _build_explosion_tween() -> void:
	$ExplodeTween.interpolate_property(self, "radius", 0.0, 16.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ExplodeTween.interpolate_property(self, "radius", 16.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.0)
	$ExplodeTween.interpolate_callback(self, 2.0, "queue_free")

func _on_Hitbox_area_entered(area : Area2D) -> void:
	var parent_of_area = area.get_parent()
	if !parent_of_area.is_queued_for_deletion():
		call_deferred("_make_another_explosion", area.get_parent().position)
		area.get_parent().queue_free()
