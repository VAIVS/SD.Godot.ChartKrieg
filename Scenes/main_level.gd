extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.modulate = Color.RED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
