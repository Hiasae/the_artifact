extends TileMap

var talked_to : int = 0

func _ready():
	$Kate.has_interacted.connect(talk_count)
	$Laura.has_interacted.connect(talk_count)
	$Nathan.has_interacted.connect(talk_count)
	$Matt.has_interacted.connect(talk_count)

func talk_count():
	talked_to += 1
	if talked_to == 4:
		$ExitArea.activate()
