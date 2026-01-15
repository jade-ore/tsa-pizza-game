extends InteractComponent

@export var inventory: ToppingStationInventoryComponent

func run(plr_inventory):
	if plr_inventory.value:
		if str(plr_inventory) != str(inventory.value): return
		inventory.add(plr_inventory.value)
	var item = inventory.subtract()
	if item:
		plr_inventory.add(item)
