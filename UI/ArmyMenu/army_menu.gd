extends Control
class_name ArmyMenu

@onready var captain_icon: TextureRect = $MarginContainer/Panel/VBoxContainer/BoxContainer/CaptainIcon
@onready var label_captain_name: Label = $MarginContainer/Panel/VBoxContainer/LabelCaptainName
@onready var unit_v_box: VBoxContainer = $MarginContainer/Panel/UnitVBox

@export var unit_box_scene: PackedScene

func display_menu(army: TestPlayer) -> void:
	build_ui(army)
	visible = true

func reset_ui() -> void:
	
	while unit_v_box.get_child_count() > 0:
		var child = unit_v_box.get_child(0)
		unit_v_box.remove_child(child)
		child.queue_free()
	

func build_ui(army: TestPlayer) -> void:
	reset_ui()
	captain_icon.texture = load(army.captain.captain_icon_path)
	label_captain_name.text = army.captain.captain_name
	
	if army.units:
		for unit: Unit in army.units:
			var unit_box: ArmyMenu_UnitBox = unit_box_scene.instantiate() as ArmyMenu_UnitBox
			unit_v_box.add_child(unit_box)
			unit_box.init_ui(unit)
			
			
