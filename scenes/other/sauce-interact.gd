extends InteractComponent

var item: Topping = Sauce.new()

func run(inventory):
	inventory.add(item)
