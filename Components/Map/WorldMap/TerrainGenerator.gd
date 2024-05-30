extends Node2D

@export var terrain_presets : Array[PackedScene] = []
var MAP_SIZE_WIDHT := 4
var MAP_SIZE_HEIGHT := 4
var MAP_TILE_SIZE := 2048

func _ready():
	var mapInfo = get_parent() as WorldMapLogic
	MAP_SIZE_HEIGHT = mapInfo.map_tiles_height
	MAP_SIZE_WIDHT = mapInfo.map_tiles_widht
	MAP_TILE_SIZE = mapInfo.map_tile_size

func generate_terrain() -> void:
	for w in MAP_SIZE_WIDHT:
		for h in MAP_SIZE_HEIGHT:
			instantiate_map_tile(Vector2(w*MAP_TILE_SIZE,h*MAP_TILE_SIZE))
			print("Set for H: %s  W: %s" % [w,h])
	
	print("Finish Map Terrain")
	get_parent().start_baking()

func instantiate_map_tile(pos:Vector2) -> void:
	print(pos)
	var instance := terrain_presets.pick_random().instantiate() as Node2D
	add_child(instance)
	instance.position = pos
	
