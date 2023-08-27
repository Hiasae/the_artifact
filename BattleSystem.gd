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
func _ready():
	set_health($Player/Healthbar, State.current_health, State.max_health)
	$Altface2.hide()
	
	display_text("Darkness beginns to creep in, you feel it approaching")
	await Signal(self, "textbox_closed")
	$Player.show()

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Player/HBoxContainer/Textbox.visible:
		emit_signal("textbox_closed")



func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Health").text = "HP: %d/%d" % [health, max_health]


func display_text(text):
	$Player/HBoxContainer/Textbox/Text.show()
	$Player/HBoxContainer/Textbox/Text.text = text

func display_textMonster(text):
	$Panel.show()
	$Panel/Label.text = text
func display_emotion(text):
	$Player/Emotion.text = text

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
			display_text("you try to subdue the monster with violence, it does not react")
			attackcount = 2
			turn_count = turn_count + 1
		else:
			display_text("It has no effect other than giving it more time to approach you")
			turn_count = turn_count + 1
	
	
func _physics_process(delta):
	display_emotion("Neutral")
	display_textMonster("A shadowy figure emerges from the darkness")
	await get_tree().create_timer(10).timeout
	display_textMonster("LET ME TOUCH YOU")
	$Panel/Label.add_theme_color_override("font_color", Color("#FF0000"))
	await get_tree().create_timer(8).timeout
	$Panel/Label.add_theme_color_override("font_color", Color("#FFFFFF"))
	display_textMonster("It looks at you, heaving its body forward")
	if Anim1 == true:
		$AnimationPlayer.play("SizeChange1")
		Anim1 = false
		await get_tree().create_timer(1).timeout
		$Panel/Label.add_theme_color_override("font_color", Color("#FF0000"))
		display_textMonster("Why do you want to leave?")
		display_emotion("Fear")
		display_text("Friend: dont falter, we got this!")
		await get_tree().create_timer(2)
		display_emotion("Neutral")
		await get_tree().create_timer(4)
		display_textMonster("Come HERE!")
		await get_tree().create_timer(4)
		$Altface2.show()




