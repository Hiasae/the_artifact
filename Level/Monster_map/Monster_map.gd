extends TileMap
@onready var dia = preload("res://Dialogue/Max.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.self_instance.freeze()
	DialogueManager.show_example_dialogue_balloon(dia,"monster_spotted")
	await DialogueManager.dialogue_ended
	Player.self_instance.unfreeze()
