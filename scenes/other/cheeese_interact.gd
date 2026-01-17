extends InteractComponent

@export var inventory: ToppingStationInventoryComponent

func run(plr_inventory):
	var item
	if plr_inventory.value:
		if str(plr_inventory) != str(inventory.value): return
		item = plr_inventory.subtract()
		inventory.add(item)
		return
	item = inventory.subtract()
	print(item)
	if item:
		plr_inventory.add(item)
