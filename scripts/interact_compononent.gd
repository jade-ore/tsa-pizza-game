extends InteractComponent

var item: Topping = Sausage.new(true)

func run(inventory):
	inventory.add(item)
