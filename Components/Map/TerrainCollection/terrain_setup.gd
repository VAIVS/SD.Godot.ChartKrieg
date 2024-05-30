extends NavigationRegion2D

@onready var terrain_polygon = $TerrainOutline.polygon

func _ready():
	$TerrainOutline/NavigationArea/AreaNavigationCollider.polygon = terrain_polygon
	var new_navigation_mesh = NavigationPolygon.new()
	var geometry = NavigationMeshSourceGeometryData2D.new()
	geometry.add_obstruction_outline(terrain_polygon)
	new_navigation_mesh.add_outline(terrain_polygon)
	new_navigation_mesh.parsed_collision_mask = 0
	NavigationServer2D.bake_from_source_geometry_data(new_navigation_mesh, NavigationMeshSourceGeometryData2D.new() )
	navigation_polygon = new_navigation_mesh
	

