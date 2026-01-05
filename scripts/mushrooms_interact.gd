extends InteractComponent

func run(inventory):
	if inventory.value is Pizza:
		inventory.value.add_topping(Mushrooms.new(true))
	inventory.add(Mushrooms.new(true))
