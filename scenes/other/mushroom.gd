extends InteractComponent

var item: Topping = Mushrooms.new(true)

func run(inventory):
	inventory.add(item)
