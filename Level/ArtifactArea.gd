extends Area2D

signal has_interacted
var interact_once : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sparkle/AnimationPlayer.play("sparkle")

func interact():
	emit_signal("has_interacted")
	AudioManager.increase_ambience()
	if interact_once:
		queue_free()
