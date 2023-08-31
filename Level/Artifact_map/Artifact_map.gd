extends TileMap

@onready var dia = preload("res://Dialogue/Max.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready():
	$ArtifactArea.has_interacted.connect(found_artifact)
	$DeadJoseph.has_interacted.connect($ExitArea.activate)
	$DeadJoseph.has_interacted.connect(replace_friend)
	
func found_artifact()-> void:
	Player.self_instance.freeze()
	$FlashingLights/AnimationPlayer.play("flash")
	SfxPlayer.play("res://Audio/Light_Artifact.ogg")
	await $FlashingLights/AnimationPlayer.animation_finished
	DialogueManager.show_example_dialogue_balloon(dia,"artifact")
	await DialogueManager.dialogue_ended
	$AnimationPlayer.play("friend_meet")
	await $AnimationPlayer.animation_finished
	Player.self_instance.unfreeze()
	
	
func replace_friend():
	SfxPlayer.play("res://Audio/monster_scream.ogg")
	await get_tree().create_timer(0.6).timeout
	Player.self_instance.freeze()
	DialogueManager.show_example_dialogue_balloon(dia,"scream")
	await DialogueManager.dialogue_ended
	Player.self_instance.unfreeze()
	var friend_sprite = load("res://Level/Artifact_map/dead_joseph.tscn").instantiate()
	Global.level.add_child(friend_sprite)
	friend_sprite.global_position = $DeadJoseph.global_position
	$DeadJoseph.queue_free()

