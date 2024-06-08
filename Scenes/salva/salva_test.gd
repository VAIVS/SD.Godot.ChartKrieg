extends Node2D

@onready var world_map: WorldMapLogic = $WorldMap
@onready var armies: Node2D = $Armies
@onready var army_selection_manager: SelectionManager = $Systens/ArmySelectionManager



@export var movement_marker_scene: PackedScene

func _ready():
	world_map.world_map_ready.connect(_on_map_ready)
	
	#For the time being done manually. 
	#In the future this will be done by the system that spawns the armies.
	
	for army: TestPlayer in armies.get_children():
		army.sig_army_selected.connect(army_selection_manager.handle_signal_on_army_selected)
	

#Todo Move the handling of map controls into the WorlMap
func set_new_marker(marker: MovementMarker) -> void:
	for item in world_map.get_children():
		if item is MovementMarker:
			item.queue_free()
	world_map.add_child(marker)
		
		

func _on_map_ready() -> void:
	#Update the region with the updated navigation mesh.
	for child in $Armies.get_children():
		child.start_navigation()
	pass



#func give_move_command(pos: Vector2) -> void:
	#var marker : MovementMarker = movement_marker_scene.instantiate() as MovementMarker
	#marker.global_position = pos
	#for army: TestPlayer in army_selection:
		#army.target_node = marker
		## Consider have start_navigation trigger within the setter of target_node.
		## Depends from navigation map baking.
		#army.start_navigation()
		#army.reset_selected_ui()
	#set_new_marker(marker)


func _on_world_map_sig_point_touched(pos: Vector2) -> void:
	print(pos)

