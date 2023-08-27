extends CharacterBody2D

@onready var sprite_2d : Sprite2D = $Sprite2D
var anim_update : float = 0.2
var anim_time : float = 0
var frame_y : int
var frame_x : int

const SPEED : float = 40

func _physics_process(delta):

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
		
	frame_x = 2*int(dir.y < 0) 
	if abs(dir.x) > 0:
		frame_x = 3*int(dir.x < 0) + int(dir.x > 0)

	sprite_2d.frame_coords = Vector2i(frame_x,frame_y)
	
	
	
	
