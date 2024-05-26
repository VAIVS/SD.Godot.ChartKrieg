extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.load_from_file("res://Assets/Map/elements/textureWater.png")
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0,0),bitmap.get_size()))
	$Polygon2D.polygons = polygons
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
