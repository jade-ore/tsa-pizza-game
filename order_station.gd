extends InteractComponent

func run(plr_inventory: InventoryComponent):
	var player = plr_inventory.get_parent() as Player
	player.order_ingredients(self)
	player.Order.connect(order)

func order(item):
	print("ordered ", item)
