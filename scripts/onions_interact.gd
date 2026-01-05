extends InteractComponent

var item: Topping = Onions.new(true)

func run(inventory):
	inventory.add(item)
