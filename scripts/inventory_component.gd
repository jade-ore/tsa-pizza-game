extends Node2D
class_name InventoryComponent

var value
var amount: int

func add(item, a = 0):
	if value is Pizza:
		for topping in value.get_toppings():
			if str(topping) == str(item): return
		value.add_topping(item)
	if value != null:
		return
	value = item

func _input(event): 
	print(event)

func subtract():
	var temp = value
	value = null
	return temp

func _to_string() -> String:
	return str(value)
