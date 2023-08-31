@tool
extends CharacterBody2D

@export var character_sprite : Texture2D
@export var frame_coord : Vector2i = Vector2i(0,0)
@onready var char_sp = $Character
@export var emote_id : int = 0
@onready var emote = $Emote
@export var has_collision : bool = true
@export var dialogue : DialogueResource
@export var can_interact : bool = true
#@onready var dia_balloon = preload("res://addons/dialogue_manager/portraits_balloon/balloon.tscn")
signal has_interacted


func _ready():
	char_sp.texture = character_sprite
	collision_layer = 3*int(has_collision)
	
func _process(_delta):
	emote.set_visible(emote_id > -1)
	if emote_id > -1:
		emote.frame = emote_id
	char_sp.frame_coords = frame_coord


func interact():
	if can_interact:
		can_interact = false
		#var bal = dia_balloon.instantiate()
		#Global.level.add_child(bal)
		#bal.start(dialogue,"start")
		DialogueManager.show_example_dialogue_balloon(dialogue,"start")
		Player.self_instance.freeze()
		await DialogueManager.dialogue_ended
		Player.self_instance.unfreeze()
		emit_signal("has_interacted")
