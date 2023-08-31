extends TileMap
@onready var dia = preload("res://Dialogue/Max.dialogue")
@onready var bal = preload("res://addons/dialogue_manager/portraits_balloon/balloon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Player.self_instance.freeze()
	var b = bal.instantiate()
	Global.level.add_child(b)
	b.start(dia,"monster_spotted")
	#DialogueManager.show_example_dialogue_balloon(dia,"monster_spotted")
	await DialogueManager.dialogue_ended
	Player.self_instance.unfreeze()
