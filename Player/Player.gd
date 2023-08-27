extends CharacterBody2D


const SPEED : float = 40

func _physics_process(delta):

	var direction = Input.get_vector("left","right","forward", "backward")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
