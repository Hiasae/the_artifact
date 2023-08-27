extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var dia = load("res://Dialogue/Dialogue1.dialogue")
	#DialogueManager.show_example_dialogue_balloon(dia,"start")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func darken_level():
	var tw = get_tree().create_tween()
	tw.tween_property(self,"modulate",Color(0.4,0.4,0.4,1.0),2.0)
