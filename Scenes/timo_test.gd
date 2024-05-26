extends Node2D

@export var speed: float = 20
@onready var cam = $Camera2D

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		cam.position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		cam.position.y += speed * delta
	if Input.is_action_pressed("ui_left"):
		cam.position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		cam.position.x += speed * delta