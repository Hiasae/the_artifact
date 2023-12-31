extends TileMap

var talked_to : int = 0
@onready var dia = preload("res://Dialogue/Max.dialogue")
@onready var bal = preload("res://addons/dialogue_manager/portraits_balloon/balloon.tscn")
@onready var anim_p = $AnimationPlayer
@onready var walk_off_area = $WalkOffArea

signal intro_played

func _ready():
	$Kate.has_interacted.connect(talk_count)
	$Laura.has_interacted.connect(talk_count)
	$Nathan.has_interacted.connect(talk_count)
	$Matt.has_interacted.connect(talk_count)
	anim_p.animation_finished.connect(self_talk)
	
func talk_count():
	talked_to += 1
	if talked_to == 4:
		walk_off_area.active = false
		await get_tree().create_timer(2).timeout
		SfxPlayer.play("res://Audio/lowFrequency_explosion_001.ogg")
		Player.self_instance.freeze()
		var b = bal.instantiate()
		Global.level.add_child(b)
		b.start(dia,"noise")
		#DialogueManager.show_example_dialogue_balloon(dia,"noise")
		await DialogueManager.dialogue_ended
		Player.self_instance.unfreeze()
		$ExitArea.activate()
		
		
func self_talk(anim: String = ""):
	if anim == "Intro":
		$Nathan/AnimationPlayer.play("kicking")
		Player.self_instance.freeze()
		print("what")
		var b = bal.instantiate()
		Global.level.add_child(b)
		b.start(dia,"first")
		#DialogueManager.show_example_dialogue_balloon(dia,"first")
		await DialogueManager.dialogue_ended
		Player.self_instance.unfreeze()

		
func start_map():
	anim_p.play("Intro")
	await anim_p.animation_finished
	intro_played.connect(Global.level.setup_player)
	emit_signal("intro_played")
