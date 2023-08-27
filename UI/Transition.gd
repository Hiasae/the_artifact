extends CanvasLayer

signal transition_ended


func fade_out():
	$AnimationPlayer.play("Fade_out")
	
func fade_in():
	$AnimationPlayer.play("Fade_in")


func _on_animation_player_animation_finished(_anim_name):
	emit_signal("transition_ended")
