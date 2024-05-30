extends Node2D

func _ready():
	$WorldMap.world_map_ready.connect(_on_map_ready)

func _on_map_ready() -> void:
	# Update the region with the updated navigation mesh.
	for child in $Armies.get_children():
		child.start_navigation()
	pass

