extends Area2D

signal has_interacted
var interact_once : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sparkle/AnimationPlayer.play("sparkle")
	has_interacted.connect(Global.do_event)

func interact():
	emit_signal("has_interacted","find_artifact")
	if interact_once:
		queue_free()
