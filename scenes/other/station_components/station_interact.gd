extends InteractComponent

@export var inventory: ToppingStationInventoryComponent

func run(plr_inventory):
	var item
	if plr_inventory.value is Pizza:
		item = inventory.subtract()
		if item in plr_inventory.value.get_toppings():
			inventory.add(item)
			return
		plr_inventory.add(item)
		return
	if plr_inventory.value:
		if str(plr_inventory) != str(inventory.value): return
		item = plr_inventory.subtract()
		inventory.add(item)
		return
	item = inventory.subtract()
	if item:
		plr_inventory.add(item)
