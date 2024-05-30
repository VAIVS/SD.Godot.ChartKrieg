extends CanvasLayer

@export var main_scene: PackedScene

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
