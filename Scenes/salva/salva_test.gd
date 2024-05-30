extends Node2D

@onready var world_map: WorldMapLogic = $WorldMap
@onready var armies: Node2D = $Armies

var army_selection: Array[TestPlayer] = []
var movement_marker_scene: PackedScene

func _ready():
	movement_marker_scene = preload("res://Components/Map/MovementMarker/MovementMarker.tscn")
	world_map.world_map_ready.connect(_on_map_ready)


func give_move_command(pos: Vector2) -> void:
	var marker : MovementMarker = movement_marker_scene.instantiate() as MovementMarker
	marker.global_position = pos
	for army: TestPlayer in army_selection:
		army.target_node = marker
		# Consider have start_navigation trigger within the setter of target_node.
		# Depends from navigation map baking.
		army.start_navigation()
		army.reset_selected_ui()
	set_new_marker(marker)
	army_selection.clear()
	

# Todo Move the handling of map controls into the WorlMap
func set_new_marker(marker: MovementMarker) -> void:
	for item in world_map.get_children():
		if item is MovementMarker:
			item.queue_free()
	world_map.add_child(marker)
		
		

func _on_map_ready() -> void:
	# Update the region with the updated navigation mesh.
	for child in $Armies.get_children():
		child.start_navigation()
	pass

func _on_world_map_sig_point_touched(pos: Vector2) -> void:
	if army_selection.size() > 0:
		give_move_command(pos)

func _on_sig_army_deselected(army: TestPlayer) -> void:
	army_selection.erase(army)

func _on_sig_army_selected(army: TestPlayer) -> void:
	if not army in army_selection:
		army_selection.append(army)
