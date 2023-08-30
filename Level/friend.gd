@tool
extends CharacterBody2D

@export var character_sprite : Texture2D
@export var frame_coord : Vector2i = Vector2i(0,0)
@onready var char_sp = $Character
@export var emote_id : int = 0
@onready var emote = $Emote
@export var has_collision : bool = true
@export var dialogue : String

func _ready():
	char_sp.texture = character_sprite
	collision_layer = int(has_collision)

func _process(_delta):
	emote.set_visible(emote_id > -1)
	if emote_id > -1:
		emote.frame = emote_id
	char_sp.frame_coords = frame_coord


func interact():
	pass
