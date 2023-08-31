extends Sprite2D

@onready var player = Player.self_instance

const SPEED : float = 40
var anim_time : float = 0.0
var anim_update : float = 0.3
var frame_x : int = 0
var frame_y : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dist = player.global_position.distance_to(global_position)
	var direction = (player.global_position - global_position).normalized()
	if dist < 10.0:
		return
	if direction:
		global_position += direction * SPEED*delta

	update_sprite_animation(direction, delta)


func update_sprite_animation(dir : Vector2, delta : float):
	if not dir:
		frame_coords = Vector2i(frame_x,0)
		return
	anim_time += delta
	if anim_time > anim_update:
		anim_time = 0
		frame_y = (frame_y + 1)%3

	frame_x = 2*int(dir.y < 0) 
	if abs(dir.x) > 0:
		frame_x = 3*int(dir.x < 0) + int(dir.x > 0)

	frame_coords = Vector2i(frame_x,frame_y)
