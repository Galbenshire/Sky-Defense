extends Sprite

export (Vector2) var velocity : Vector2

func _physics_process(delta):
	position += velocity * delta
