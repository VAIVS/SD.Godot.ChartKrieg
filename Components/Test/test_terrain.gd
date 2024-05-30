extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionPolygon2D.polygon = $Polygon2D.polygon
	var new_navigation_mesh = NavigationPolygon.new()
	var geometry = NavigationMeshSourceGeometryData2D.new()
	geometry.add_obstruction_outline($Polygon2D.polygon)
	new_navigation_mesh.add_outline($Polygon2D.polygon)
	new_navigation_mesh.parsed_collision_mask = 0
	NavigationServer2D.bake_from_source_geometry_data(new_navigation_mesh, NavigationMeshSourceGeometryData2D.new() )
	navigation_polygon = new_navigation_mesh
	print_debug("Finsih Terrain Navigation")

