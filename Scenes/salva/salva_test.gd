extends Node2D
class_name GameStateManager

enum game_states {
	LOADING,
	MAPIDLE,
	ARMY_MENU
}

@onready var world_map: WorldMapLogic = $WorldMap
@onready var armies: Node2D = $Armies
@onready var army_selection_manager: SelectionManager = $Systens/ArmySelectionManager
@onready var queue: Array[GameStateEvent] = [];
@onready var current_state: game_states = game_states.LOADING
@onready var army_menu: ArmyMenu = $UI/ArmyMenu


@export var movement_marker_scene: PackedScene

func _ready():
	world_map.world_map_ready.connect(_on_map_ready)
	
	#For the time being done manually. 
	#In the future this will be done by the system that spawns the armies.
	for army: TestPlayer in armies.get_children():
		army.sig_army_selected.connect(army_selection_manager.handle_signal_on_army_selected)
		
	
	armies.get_children()[0].units.append(Soldier.new())
	armies.get_children()[0].units[0].count = 2
	armies.get_children()[0].captain = Captain_Arragorn.new()
	
	armies.get_children()[1].units.append(Scout.new())
	armies.get_children()[1].units[0].count = 3
	armies.get_children()[1].captain = Captain_Shady.new()
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("press_a"):
		queue_game_state_event(GameStatePressAEvent.new())
	elif Input.is_action_just_pressed("press_x"):
		queue_game_state_event(GameStatePressXEvent.new())
	elif Input.is_action_just_pressed("press_esc"):
		queue_game_state_event(GameStatePressESCEvent.new())
	
	var gameEvent: GameStateEvent = queue.pop_front()
	if gameEvent:
		process_game_event(gameEvent)
	

#Todo Move the handling of map controls into the WorlMap
func set_new_marker(marker: MovementMarker) -> void:
	for item in world_map.get_children():
		if item is MovementMarker:
			item.queue_free()
	world_map.add_child(marker)
		
		

func _on_map_ready() -> void:
	#Update the region with the updated navigation mesh.
	#for child in $Armies.get_children():
		#child.start_navigation()
	current_state = game_states.MAPIDLE
	print("Loading finished")

func _on_world_map_sig_point_touched(pos: Vector2) -> void:
	queue_game_state_event(GameStateClickedOnMapEvent.new(pos))
	

func queue_game_state_event(queueItem: GameStateEvent):
	queue.append(queueItem)

func process_game_event(game_event: GameStateEvent) -> void:
	# refactor this in a structure which can directly access the correct resolve-function by game state and event type
	# Maybe a dictionary of some sort?
	if current_state == game_states.MAPIDLE:
		if game_event is GameStateClickedOnMapEvent:
			resolve_mapidle_clicked_on_map(game_event)
		elif game_event is GameStatePressAEvent:
			resolve_mapidle_pressed_a()
		elif game_event is GameStatePressXEvent:
			resolve_mapidle_pressed_x()
	elif current_state == game_states.ARMY_MENU:
		if game_event is GameStatePressESCEvent:
			resolve_armymenu_pressed_ESC()
		if game_event is GameStatePressAEvent:
			resolve_armymenu_pressed_ESC()
		
		

func resolve_mapidle_clicked_on_map(event: GameStateClickedOnMapEvent) -> void:
	var selection : Array = army_selection_manager.get_selection()
	if selection.size() > 0:
		var marker : MovementMarker = movement_marker_scene.instantiate() as MovementMarker
		marker.global_position = event.clicked_position
		for army: TestPlayer in selection:
			army.target_node = marker
			army.start_navigation()
		set_new_marker(marker)

func resolve_mapidle_pressed_a() -> void:
	var selection : Array[TestPlayer]= army_selection_manager.get_selection()
	if selection.size() == 1:
		army_menu.display_menu(selection[0])
		current_state = game_states.ARMY_MENU

func resolve_mapidle_pressed_x() -> void:
	army_selection_manager.clear_selection()

func resolve_armymenu_pressed_ESC() -> void:
	army_menu.visible = false
	current_state = game_states.MAPIDLE



class GameStateEvent:
	var object
	func _init(o):
		object = o
		
class GameStateClickedOnMapEvent extends GameStateEvent:
	func _init(o):
		super(o)
	var clicked_position: Vector2:
		get:
			return object as Vector2
			
class GameStateSelectArmyEvent extends GameStateEvent:
	func _init(o):
		super(o)
	var selected_army: TestPlayer:
		get:
			return object as TestPlayer

class GameStateUnselectArmyEvent extends GameStateEvent:
	func _init(o):
		super(o)
	var selected_army: TestPlayer:
		get:
			return object as TestPlayer
			
class GameStateSelectMultipleArmiesEvent extends GameStateEvent:
	func _init(o):
		super(o)
	var selected_army: Array[TestPlayer]:
		get:
			var res : Array[TestPlayer] = []
			res.append_array(object)
			return res as Array[TestPlayer]

class GameStatePressAEvent extends GameStateEvent:
	func _init():
		super(null)

class GameStatePressXEvent extends GameStateEvent:
	func _init():
		super(null)

class GameStatePressESCEvent extends GameStateEvent:
	func _init():
		super(null)



