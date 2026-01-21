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
	if item:
		var plr = plr_inventory.get_parent()
		var size = await plr.get_dough_size()
		item.size = size
		plr_inventory.add(item)
