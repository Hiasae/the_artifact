extends Area2D

@export var active : bool = false

@export var next_map_path : String
@export var next_spawn_name : String = "Playerspawn"
signal level_exited

@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("blink")
	set_visible(active)

func activate(val : bool = true)->void:
	active = val
	set_visible(active)


func _on_body_entered(body):
	if body is Player and active:
		emit_signal("level_exited", next_map_path, next_spawn_name)
		
