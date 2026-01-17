extends Label

func _process(delta: float) -> void:
	text = str($"../PepperoniInventory".amount)
