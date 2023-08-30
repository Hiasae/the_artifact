extends CharacterBody2D

var frozen : bool = false
const SPEED : float = 80
var chasing_player : bool = false

signal start_battle

func _ready():
	start_battle.connect(Global.start_battle)

func _physics_process(_delta):
	if frozen:
		return
	if not chasing_player:
		return
	var direction = (Player.self_instance.global_position - global_position).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	

func _on_detection_body_entered(body):
	if body is Player:
		chasing_player = true


func _on_fight_detection_body_entered(body):
	emit_signal("start_battle","first")
