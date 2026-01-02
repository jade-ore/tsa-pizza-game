extends InteractComponent

@export var inventory: InventoryComponent

func _process(delta: float) -> void:
	$"../Control/Label".text = str(inventory)

func run(player_inventory):
	var item
	if inventory.value != null: # Check if inventory already has something
		if inventory.value is Pizza and player_inventory.value is Topping:
			# Add topping to pizza
			item = player_inventory.subtract()
			inventory.add(item)
			return
		if player_inventory.value != null: return # Return if player already has something
		# Give item to player
		item = inventory.subtract()
		player_inventory.add(item)
		return
	# Give item to station
	var subtracted = player_inventory.subtract()
	inventory.add(subtracted)
