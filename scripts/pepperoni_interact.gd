extends InteractComponent

var item: Topping = Pepperoni.new(true)

func run(inventory):
	inventory.add(item)
