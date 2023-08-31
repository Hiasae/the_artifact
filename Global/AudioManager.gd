extends Node

@onready var players : Array[AudioStreamPlayer]
var curr_player : int = 0
@onready var amb_player

func _ready():
	for i in range(2):
		var new_p = AudioStreamPlayer.new()
		new_p.bus = "Music"
		add_child(new_p)
		players.append(new_p)
	amb_player = AudioStreamPlayer.new()
	add_child(amb_player)
	amb_player.bus = "Music"
	amb_player.volume_db = -80.0
	process_mode = Node.PROCESS_MODE_ALWAYS

func play_music(path : String, transition_time : float = 1.5):
	curr_player = (curr_player + 1)%2
	players[curr_player].stream = load(path)
	players[curr_player].volume_db = -80.0
	players[curr_player].play()
	var tw = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	tw.tween_property(players[curr_player],"volume_db",0.0,transition_time)
	tw.tween_property(players[(curr_player + 1)%2],"volume_db",-80.0,transition_time)

func lower_volume(transition_time : float = 1.5):
	var tw = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(players[curr_player],"volume_db",-20.0,transition_time)
	
func play_ambience(path : String,transition_time : float = 1.5):
	amb_player.stream = load(path)
	amb_player.play()
	var tw = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(amb_player,"volume_db",-15.0,transition_time)
	
func increase_ambience(transition_time : float = 1.5):
	var tw = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(amb_player,"volume_db",-5.0,transition_time)

func reset_ambience(transition_time : float = 1.5):
	var tw = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(amb_player,"volume_db",-15.0,transition_time)
