extends Node
class_name GameStateManager

enum game_states {
	MAPIDLE,
	ARMY_ACTIONS,
	ARMY_MENU
}

enum game_event_types {
	SELECTED,
	UNSELECTED,
	CLICKED
}

@onready var queue: Array[GameStateEvent] = [];
@onready var current_state: game_states = game_states.MAPIDLE

func _process(delta: float) -> void:
	var gameEvent: GameStateEvent = queue.pop_front()
	if gameEvent:
		pass
	

func queue_game_state_event(queueItem: GameStateEvent):
	queue.append(queueItem)



class GameStateEvent:
	
	var game_event_type: game_event_types
	var object
	
	func _init(et: game_event_types, o):
		game_event_type = et
		object = o
		
