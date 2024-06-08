extends Node
class_name SelectionManager

@export var army_highlight_scene : PackedScene
@export var game_state_manager: GameStateManager

var cursor_highlits_dic = {
	
}

func handle_signal_on_army_selected(army: TestPlayer):
	#In future, further modularize this
	var army_selection: Array = cursor_highlits_dic.keys()
	if army in army_selection:
		cursor_highlits_dic[army].queue_free()
		cursor_highlits_dic.erase(army)
		game_state_manager.queue_game_state_event(GameStateManager.GameStateEvent.new(GameStateManager.game_event_types.UNSELECTED, army))
	else:
		var army_highligt = army_highlight_scene.instantiate()
		army.add_child(army_highligt)
		cursor_highlits_dic[army] = army_highligt
		game_state_manager.queue_game_state_event(GameStateManager.GameStateEvent.new(GameStateManager.game_event_types.SELECTED, army))
		
		
	
	
