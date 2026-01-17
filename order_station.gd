extends InteractComponent
signal OrderFood


func run(plr_inventory: InventoryComponent):
	var player = plr_inventory.get_parent() as Player
	player.order_ingredients(self)
	if not player.Order.is_connected(order):
		player.Order.connect(order)

func order(item):
	OrderFood.emit(item)
