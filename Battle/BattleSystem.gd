extends Control

var current_health = 10
var max_health = 10
var damage = 20
var moin = 1
var attackcount = 1
var turn_count = 1
var EnemyAttackOptions = [1, 2, 3]
var rand_value = EnemyAttackOptions[randi() % EnemyAttackOptions.size()]
var AttackPattern = 1
var Emotion = 1# 2 = fear #3=anger #4 =nonchalant
var Anim1 = true
var Anim2 = true
var Anim3 = true


signal textbox_closed
# Called when the node enters the scene tree for the first time.

func start():
	set_health($%Healthbar, State.current_health, State.max_health)
	$Altface2.hide()
	SfxPlayer.play("res://Audio/x2mate.com - Heartbeat Sound effect _ No Copyright (128 kbps).mp3")
	display_text("Darkness beginns to creep in, you feel it approaching")
	await Signal(self, "textbox_closed")
	$Player.show()
	AudioManager.play_music("res://Audio/Horror_boss.ogg")
	

func _ready():
	display_emotion("Neutral")
	set_health($%Healthbar, State.current_health, State.max_health)
	$Altface2.hide()

	display_text("Darkness beginns to creep in, you feel it approaching")
	await textbox_closed   #Signal(self, "textbox_closed")
	$Player.show()
	start_sequence()

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Player/PlayerPanel/HBoxContainer/Textbox.visible:
		emit_signal("textbox_closed")


func set_health(progress_bar, health, _max_health):
	progress_bar.value = health
	progress_bar.max_value = _max_health
	progress_bar.get_node("Health").text = "HP: %d/%d" % [health, _max_health]


func display_text(text):
	%Text.show()
	%Text.text = text

func display_textMonster(text):
	$Background.show()
	%TopLabel.text = text
	
func display_emotion(text):
	%Emotion.text = text

func _on_flee_button_pressed():
	if moin == 1:
		display_text("Friend: You cannot leave me alone like this!")
		moin = 2
		turn_count = turn_count + 1
	else:
		if moin == 2:
			display_text("Friend: You wont leave me like this")
			moin = 3
			turn_count = turn_count + 1
		else:
			if moin == 3:
				display_text("The guilt of abandoning your friend binds you to this place, you will not leave")
				turn_count = turn_count + 1





func _on_fight_button_pressed():
	if attackcount == 1:
		SfxPlayer.play("res://Audio/mosnster_being_hit.ogg")
		display_text("you try to subdue the monster with violence, it does not react")
		attackcount = 2
		turn_count = turn_count + 1
	else:
		SfxPlayer.play("res://Audio/mosnster_being_hit_2.ogg")
		display_text("It has no effect other than giving it more time to approach you")
		turn_count = turn_count + 1
	
	
func start_sequence():
	display_emotion("Neutral")
	display_text("You: What is that....thing?")
	display_textMonster("........")
	await get_tree().create_timer(3).timeout
	display_text("oh no")
	%TopLabel.set("theme_override_colors/font_color", Color("#FF0000"))
	display_textMonster("AHHHHHHHHHH")
	await get_tree().create_timer(4).timeout
	display_text("You: its a Monster!")
	display_textMonster(" @%#^&$@^&7")
	await get_tree().create_timer(5).timeout
	display_text("what?")
	await get_tree().create_timer(3).timeout
	display_textMonster("(&(*&^*((*--love--*(^(&*(-What-^&*&%*&%^%&^$-doing")
	$AnimationPlayer.play("RESET")
	await get_tree().create_timer(4).timeout
	display_text("You:(it can talk! what is this monstrosity ! it ....loves to do this? to kill me?!)")
	await get_tree().create_timer(3).timeout
	display_textMonster("no-((^&*58-Love --*UH&*Y- to you*(&*&(")
	await get_tree().create_timer(2).timeout
	display_text("(what madness is this creature spewing... i better do something quick or ill die here!)")
	display_emotion("Fear")
	await get_tree().create_timer(3).timeout
	display_textMonster("COME HERE")
	await get_tree().create_timer(2).timeout
	$Altface2.show()
	AudioManager.lower_volume()
	AudioManager.lower_ambience()
	await get_tree().create_timer(1).timeout
	SfxPlayer.play("res://Audio/monster_dying.ogg")
	
	Global.screen_darken()
	await get_tree().create_timer(4).timeout
	SfxPlayer.play("res://Audio/death_end_screen.ogg")
	await get_tree().create_timer(9).timeout
	Global.end_battle()
	#Global.end_battle()
	
	#get_tree().change_scene_to_file("res://3dlevel.tscn")



