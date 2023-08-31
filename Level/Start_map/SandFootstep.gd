extends AudioStreamPlayer

var active : bool = false

func set_active(val : bool):
	active = val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active and not playing:
		pitch_scale = 0.9+0.2*randf()
		play()
