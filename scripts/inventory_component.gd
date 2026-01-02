extends Node2D
class_name InventoryComponent

var value

func add(item):
	if value is Pizza:
		for topping in value.get_toppings():
			print("comparing ", str(topping), " with ", item)
			if str(topping) == str(item): return
		print("added_topping")
		value.add_topping(item)
	if value != null:
		return
	value = item

func subtract():
	var temp = value
	value = null
	return temp

func _to_string() -> String:
	return str(value)
