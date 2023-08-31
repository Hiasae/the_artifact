extends TileMap

@onready var dia = preload("res://Dialogue/Max.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready():
	$ArtifactArea.has_interacted.connect(found_artifact)
	$DeadJoseph.has_interacted.connect($ExitArea.activate)
	
func found_artifact()-> void:
	Player.self_instance.freeze()
	$FlashingLights/AnimationPlayer.play("flash")
	SfxPlayer.play("res://Audio/Light_Artifact.ogg")
	await $FlashingLights/AnimationPlayer.animation_finished
	DialogueManager.show_example_dialogue_balloon(dia,"artifact")
	$AnimationPlayer.play("friend_meet")
	await $AnimationPlayer.animation_finished
	Player.self_instance.unfreeze()
	

