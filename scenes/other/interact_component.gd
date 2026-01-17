extends InteractComponent

@export var inventory: ToppingStationInventoryComponent

func run(plr_inventory):
	var item
	if plr_inventory.value:
		if str(plr_inventory) != str(inventory.value): return
		item = plr_inventory.subtract()
		inventory.add(item)
		return
	if inventory.amount == 0:
		return
	item = inventory.subtract()
	if item:
		plr_inventory.add(item)
