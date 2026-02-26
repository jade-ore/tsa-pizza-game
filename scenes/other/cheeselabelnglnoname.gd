extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var amount = $"../CheeseInventory".get_amount()
	if amount > 9999:
		visible = false
	else:
		visible = true
	text = str(amount)
