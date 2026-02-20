extends Label

func _process(delta: float) -> void:
	if Global.players.is_empty():
		return
	text = str(Global.players[0].inventory)
