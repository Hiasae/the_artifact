extends Node2D

@onready var player = Player.self_instance
@onready var map_piece = $"Map piece"



func _ready():
	Global.setup()
	get_tree().get_nodes_in_group("Level_exits")[0].level_exited.connect(change_map_piece)
	pass
	#var dia = load("res://Dialogue/Dialogue1.dialogue")
	#DialogueManager.show_example_dialogue_balloon(dia,"start")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func darken_level():
	var tw = get_tree().create_tween()
	tw.tween_property(self,"modulate",Color(0.4,0.4,0.4,1.0),2.0)


func change_map_piece(to : String, player_spawn_name : String):
	if to == "res://Level/Artifact_map/Artifact_map.tscn":
		AudioManager.lower_volume()
	elif to == "res://Level/Monster_map/Monster_map.tscn":
		AudioManager.play_music("res://Audio/Horror_2.1.ogg")
		AudioManager.reset_ambience()
	map_piece.get_child(0).queue_free()
	var new_piece = load(to).instantiate()
	map_piece.call_deferred("add_child",new_piece)
	await get_tree().process_frame
	get_tree().get_nodes_in_group("Level_exits")[0].level_exited.connect(change_map_piece)
	for i in get_tree().get_nodes_in_group("PlayerSpawns"):
		if player_spawn_name == i.name:
			player.global_position = i.global_position
			if not get_tree().get_nodes_in_group("DeadFriend").is_empty():
				get_tree().get_nodes_in_group("DeadFriend")[0].global_position = i.global_position
			return


func setup_player():
	player.global_position = get_tree().get_nodes_in_group("PlayerSpawns")[0].global_position
	player.show()
	player.unfreeze()
	
