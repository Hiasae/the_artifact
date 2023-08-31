extends Area2D

var active: bool = true
@onready var bal = preload("res://addons/dialogue_manager/portraits_balloon/balloon.tscn")
@onready var dia = preload("res://Dialogue/Max.dialogue")

func _on_body_entered(body):
	if body is Player and active:
		var b = bal.instantiate()
		Global.level.add_child(b)
		b.start(dia,"walk_off")
		active = false
