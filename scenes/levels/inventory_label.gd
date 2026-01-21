extends Label

func _process(delta: float) -> void:
	text = str(Global.players[0].inventory)
