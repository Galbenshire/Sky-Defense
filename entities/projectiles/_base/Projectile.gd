extends Node2D

export (float) var speed : float = 50.0

var direction : Vector2 = Vector2.RIGHT

func _physics_process(delta : float) -> void:
	_move_projectile(delta)

func _move_projectile(delta : float) -> void:
	position += direction * speed * delta