extends InteractComponent

var item: Topping = Cheese.new(true)

func run(inventory):
	inventory.add(item)
