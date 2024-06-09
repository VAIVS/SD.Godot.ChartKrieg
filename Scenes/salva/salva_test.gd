extends Node2D
class_name GameStateManager

enum game_states {
	MAPIDLE,
	ARMY_ACTIONS,
	ARMY_MENU
}

@onready var world_map: WorldMapLogic = $WorldMap
@onready var armies: Node2D = $Armies
@onready var army_selection_manager: SelectionManager = $Systens/ArmySelectionManager
@onready var queue: Array[GameStateEvent] = [];
@onready var current_state: game_states = game_states.MAPIDLE


@export var movement_marker_scene: PackedScene

func _ready():
	world_map.world_map_ready.connect(_on_map_ready)
	
	#For the time being done manually. 
	#In the future this will be done by the system that spawns the armies.
	for army: TestPlayer in armies.get_children():
		army.sig_army_selected.connect(army_selection_manager.handle_signal_on_army_selected)

func _process(_delta: float) -> void:
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
	for child in $Armies.get_children():
		child.start_navigation()
	pass

func _on_world_map_sig_point_touched(pos: Vector2) -> void:
	queue_game_state_event(GameStateClickedOnMapEvent.new(pos))
	

func queue_game_state_event(queueItem: GameStateEvent):
	queue.append(queueItem)

func process_game_event(game_event: GameStateEvent) -> void:
	# refactor this in a structure which can directly access the correct resolve-function by game state and event type
	# Maybe a dictionary of some sort?
	if current_state == game_states.MAPIDLE:
		if game_event is GameStateSelectArmyEvent:
			pass 
		elif game_event is GameStateSelectMultipleArmiesEvent:
			pass 
		elif game_event is GameStateUnselectArmyEvent:
			pass 
		elif game_event is GameStateClickedOnMapEvent:
			resolve_mapidle_clicked_on_map(game_event)

func resolve_mapidle_clicked_on_map(event: GameStateClickedOnMapEvent) -> void:
	var selection : Array = army_selection_manager.get_selection()
	if selection.size() > 0:
		var marker : MovementMarker = movement_marker_scene.instantiate() as MovementMarker
		marker.global_position = event.clicked_position
		for army: TestPlayer in selection:
			army.target_node = marker
			army.start_navigation()
		set_new_marker(marker)

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

