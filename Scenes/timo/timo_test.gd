extends Node2D

@export var speed: float = 20
@onready var cam = $Camera2D

func _ready():
	$WorldMap.world_map_ready.connect(_on_map_ready)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		cam.position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		cam.position.y += speed * delta
	if Input.is_action_pressed("ui_left"):
		cam.position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		cam.position.x += speed * delta
	if Input.is_action_pressed("zoom_in"):
		cam.zoom -= Vector2(0.01,0.01)
	if Input.is_action_pressed("zoom_out"):
		cam.zoom += Vector2(0.01,0.01)

func _on_map_ready() -> void:
	# Update the region with the updated navigation mesh.
	for child in $Armies.get_children():
		child.start_navigation()
	pass

