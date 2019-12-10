extends Line2D

func _draw():
	draw_line(Vector2(), get_local_mouse_position(), Color.blue)

func _process(delta):
	#points[1] = get_global_mouse_position()
	update()
