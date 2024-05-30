extends NavigationRegion2D

class_name WorldMapLogic

var navigation_mesh: NavigationPolygon
var source_geometry : NavigationMeshSourceGeometryData2D
var parent_node: Node2D
var world_outline: PackedVector2Array

@export_category("Map Size Settings")
@export var map_tiles_widht := 4
@export var map_tiles_height := 4
@export var map_tile_size := 2048

signal world_map_ready

func _ready():
	parent_node = self
	navigation_mesh = NavigationPolygon.new()
	source_geometry = NavigationMeshSourceGeometryData2D.new()
	world_outline = $MapOutline/MapCollision.polygon
	$Terrain.generate_terrain()

func start_baking():
	NavigationServer2D.parse_source_geometry_data(navigation_mesh, source_geometry, parent_node, on_parse_done )
	pass 


func _on_timer_timeout():
	#NavigationServer2D.parse_source_geometry_data(navigation_mesh, source_geometry, parent_node, on_parse_done )
	pass 
	
func on_parse_done():
	source_geometry.add_traversable_outline(world_outline)
	NavigationServer2D.bake_from_source_geometry_data_async(
		navigation_mesh,
		source_geometry,
		on_baking_done
	)

func on_baking_done() -> void:
	NavigationServer2D.region_set_navigation_polygon(parent_node.get_region_rid(), navigation_mesh)
	parent_node.navigation_polygon = navigation_mesh
	world_map_ready.emit()
	
