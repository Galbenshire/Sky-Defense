extends Node2D

onready var ExplosionCollsion : CircleShape2D = $Hitbox/Collision.shape

const MAX_RADIUS := 16.0

var radius : float setget set_radius

func _ready() -> void:
	_build_explosion_tween()
	$RadiusTween.start()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color.white)

func _process(delta : float) -> void:
	update()

func set_radius(value : float) -> void:
	radius = value
	ExplosionCollsion.radius = radius

func _build_explosion_tween() -> void:
	$RadiusTween.interpolate_property(self, "radius", 0.0, MAX_RADIUS, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$RadiusTween.interpolate_property(self, "radius", MAX_RADIUS, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.0)
	$RadiusTween.interpolate_callback(self, 2.0, "queue_free")