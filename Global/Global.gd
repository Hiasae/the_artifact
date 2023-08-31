extends Node

@onready var tr_layer
@onready var battle
@onready var level

@onready var endtxt

signal screen_darkened

func setup():
	tr_layer = get_tree().get_nodes_in_group("Transition")[0]
	battle = get_tree().get_nodes_in_group("Battlesystem")[0]
	level = get_tree().get_nodes_in_group("Level")[0]
	endtxt = get_tree().get_nodes_in_group("EndText")[0]

#func do_event(val : String):
#	match val:
#		"find_artifact":
#			print("found_artifact")
#			get_tree().get_nodes_in_group("Level_exits")[0].activate()
#			#start_battle("first")


func start_battle(id : String):
	#get_tree().paused = true
	tr_layer.fade_in()
	await tr_layer.transition_ended
	#tr_layer.fade_out()
	level.process_mode =  Node.PROCESS_MODE_DISABLED
	battle.process_mode = Node.PROCESS_MODE_INHERIT
	match id:
		"first":
			battle.show()
			battle.start()
		
	tr_layer.fade_out()
	
func end_battle():
	endtxt.show_text()
	
	#tr_layer.fade_in()
	#await tr_layer.transition_ended
	#battle.hide()
	#battle.process_mode = Node.PROCESS_MODE_DISABLED
	#level.process_mode =  Node.PROCESS_MODE_INHERIT
	#get_tree().paused = false
	#tr_layer.fade_out()

func screen_darken():
	tr_layer.fade_in()
	await tr_layer.transition_ended
	#emit_signal("screen_darkened")
	
#func screen_lighten():
	#tr_layer.fade_out()
	#await tr_layer.transition_ended
