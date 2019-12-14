extends CollisionShape2D

func _ready():
	var s = shape
	if shape:
		shape = shape.duplicate()
