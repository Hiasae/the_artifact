extends AnimationPlayer

signal intro_played

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("forward"):
		intro_played.connect(Global.level.setup_player)
		play("Intro")
		await animation_finished
		emit_signal("intro_played")
