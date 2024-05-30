extends Camera2D

@export var speed = 50

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("zoom_in"):
		zoom -= Vector2(0.01,0.01)
	if Input.is_action_pressed("zoom_out"):
		zoom += Vector2(0.01,0.01)
