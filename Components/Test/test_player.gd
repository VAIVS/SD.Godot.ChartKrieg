extends CharacterBody2D
class_name TestPlayer

#Emitted whenever a touch ( or click) event is triggerd.
#Handling the outcome will be done by the game systems above.
signal sig_army_selected(army: TestPlayer)

@export var speed = 50
var nav_agent: NavigationAgent2D
@export var target_node: Node2D = null
@export var can_mountain: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D



var captain: Captain:
	set(new_captain):
		captain = new_captain
		sprite_2d.texture = load(new_captain.captain_icon_path)
		
var units: Array[Unit] = []


func _ready():
	nav_agent = $Navigation/NavigationAgent2D
	if can_mountain:
		nav_agent.set_navigation_layer_value(2,can_mountain)

func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = axis * speed

	move_and_slide()

func start_navigation():
	if target_node:
		nav_agent.target_position = target_node.global_position


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch:
		if event.pressed == false:
			sig_army_selected.emit(self)
