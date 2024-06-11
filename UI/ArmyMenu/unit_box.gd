extends HBoxContainer
class_name ArmyMenu_UnitBox

@onready var unit_icon: TextureRect = $UnitIcon
@onready var label_unit_name: Label = $LabelUnitName
@onready var label_amount: Label = $LabelAmount


func init_ui(unit: Unit):
	unit_icon.texture = load(unit.icon_path)
	label_amount.text = str(unit.count)
	label_unit_name.text = unit.unit_name
	
