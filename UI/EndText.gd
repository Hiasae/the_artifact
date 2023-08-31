extends MarginContainer


func show_text():
	show()
	$AnimationPlayer.play("show_text")


func _on_exit_button_button_up():
	get_tree().quit()
