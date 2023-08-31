extends AnimationPlayer

signal intro_played

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	play("Intro")
	await animation_finished
	intro_played.connect(Global.level.setup_player)
	emit_signal("intro_played")
