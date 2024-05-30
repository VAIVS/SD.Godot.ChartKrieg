extends Node

@export var map_node: WorldMapLogic
@export var army_group: Node2D
@export var target_group: Node2D

func _ready():
	map_node.world_map_ready.connect(_on_map_ready)

func _on_map_ready() -> void:
	# Update the region with the updated navigation mesh.
	for child: TestPlayer in army_group.get_children():
		child.target_node = target_group.get_children().pick_random() as Node2D
		child.start_navigation()
	pass
