extends Area2D

var active : bool = true


func _on_body_entered(body):
	if body is Player and active:
		active = false
		$AnimationPlayer.play("crab_disappear")
