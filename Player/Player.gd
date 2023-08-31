extends CharacterBody2D
class_name Player

@onready var sprite_2d : Sprite2D = $Sprite2D
var anim_update : float = 0.2
var anim_time : float = 0
var frame_y : int
var frame_x : int

static var self_instance 

const SPEED : float = 40
@onready var interact_area = $InteractArea
var frozen : bool = false
@onready var emote = $Emote
@onready var footsteps = $Footsteps

@onready var dia = preload("res://Dialogue/Max.dialogue")


func _ready():
	self_instance = self
	frozen = true
	hide()

	
	
func _process(_delta):
	if frozen:
		return
	if interact_area.get_overlapping_areas().is_empty() and interact_area.get_overlapping_bodies().is_empty():
		emote.hide()
		return

	if not interact_area.get_overlapping_areas().is_empty() and interact_area.get_overlapping_areas()[0].has_method("interact"):
		emote.show()
		emote.frame = 3

	if not interact_area.get_overlapping_bodies().is_empty() and interact_area.get_overlapping_bodies()[0].has_method("interact"):
		emote.show()
		emote.frame = 3

	if Input.is_action_just_pressed("interact"):
		if not interact_area.get_overlapping_areas().is_empty() and interact_area.get_overlapping_areas()[0].has_method("interact"):
			interact_area.get_overlapping_areas()[0].interact()
		elif not interact_area.get_overlapping_bodies().is_empty() and interact_area.get_overlapping_bodies()[0].has_method("interact"):
			interact_area.get_overlapping_bodies()[0].interact()

func _physics_process(delta):
	if frozen:
		return
	var direction = Input.get_vector("left","right","forward", "backward")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	update_sprite_animation(direction, delta)


func update_sprite_animation(dir : Vector2, delta : float):
	if not dir:
		sprite_2d.frame_coords = Vector2i(frame_x,0)
		return
	anim_time += delta
	if anim_time > anim_update:
		anim_time = 0
		frame_y = (frame_y + 1)%3
		footsteps.pitch_scale = (0.9+0.2*randf())
		footsteps.play()
		
	frame_x = 2*int(dir.y < 0) 
	if abs(dir.x) > 0:
		frame_x = 3*int(dir.x < 0) + int(dir.x > 0)

	sprite_2d.frame_coords = Vector2i(frame_x,frame_y)
	
	
func freeze():
	frozen = true

func unfreeze():
	frozen = false
	
