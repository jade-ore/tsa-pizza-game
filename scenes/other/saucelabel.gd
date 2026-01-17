extends Label

func _process(delta: float) -> void:
	text = str($"../SauceInventory".amount)
