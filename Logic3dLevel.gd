extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Sprite3D.position = Vector3(-1.53, 1.098, 0.477)
	await get_tree().create_timer(4).timeout
	$Sprite3D.position = Vector3(-0.95, 1.098, 0.477)
	await get_tree().create_timer(4).timeout
	$Sprite3D.position = Vector3(0.165, 1.098, 0.477)
	await get_tree().create_timer(4).timeout
	$Sprite3D.position = Vector3(0.946, 1.077, 0.396)
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://end_scene.tscn")
	
