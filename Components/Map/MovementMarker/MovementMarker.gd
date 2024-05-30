extends Node2D
class_name MovementMarker

func _on_area_2d_body_entered(_body: Node2D) -> void:
	# currently only the armies will only be able to collide with this map control
	queue_free()
