extends InteractComponent

var item: Topping = Olives.new(true)

func run(inventory):
	inventory.add(item)
