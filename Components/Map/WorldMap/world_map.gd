extends NavigationRegion2D

var navigation_mesh: NavigationPolygon
var source_geometry : NavigationMeshSourceGeometryData2D
var parent_node: Node2D
var world_outline: PackedVector2Array
signal world_map_ready

func _ready():
	parent_node = self
	navigation_mesh = NavigationPolygon.new()
	source_geometry = NavigationMeshSourceGeometryData2D.new()
	world_outline = $MapOutline/MapCollision.polygon

func _on_timer_timeout():
	NavigationServer2D.parse_source_geometry_data(navigation_mesh, source_geometry, parent_node, on_parse_done )

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
	
