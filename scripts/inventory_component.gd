extends Node2D
class_name InventoryComponent

var value

func add(item):
	if value is Pizza:
		if item is not Topping: return
		if value.cooked: return
		for topping in value.get_toppings():
			if str(topping) == str(item): return
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
