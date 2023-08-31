extends ColorRect

func _on_start_button_button_down() -> void:
	Global.level.start()
	#get_tree().paused = false
	hide()
	AudioManager.play_ambience("res://Audio/background_beach_noise.ogg")
	AudioManager.play_music("res://Audio/soft.ogg")
	#get_tree().change_scene_to_file("res://level.tscn")
	

func _on_exit_button_button_down() -> void:
	get_tree().quit()

