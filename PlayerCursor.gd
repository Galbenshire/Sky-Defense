extends Sprite

export (float) var move_speed : float = 200.0

func _ready():
	pass

func _process(delta):
	$Fixed/Debugging.text = str(get_rect())

func _physics_process(delta):
	var velocity = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
			int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))).normalized()
	velocity *= move_speed
	
	position += velocity * delta
	
	var viewport_bounds = get_viewport_rect()
	var sprite_size = get_rect()
	
	position.x = clamp(position.x, viewport_bounds.position.x - sprite_size.position.x, viewport_bounds.end.x + sprite_size.position.x)
	position.y = clamp(position.y, viewport_bounds.position.y - sprite_size.position.y, viewport_bounds.end.y + sprite_size.position.y)