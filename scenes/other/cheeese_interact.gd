extends InteractComponent

@export var inventory: ToppingStationInventoryComponent

var item: Topping = Cheese.new(true)

func run(plr_inventory):
	plr_inventory.add(item)
