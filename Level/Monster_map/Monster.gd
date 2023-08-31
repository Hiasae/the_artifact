extends CharacterBody2D

var frozen : bool = false
const SPEED : float = 65
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
	if body is Player and not chasing_player:
		SfxPlayer.play("res://Audio/monster_scream.ogg")
		chasing_player = true


func _on_fight_detection_body_entered(body):
	if body is Player:
		SfxPlayer.play("res://Audio/monster_scream_fight_initiates.ogg")
		emit_signal("start_battle","first")
