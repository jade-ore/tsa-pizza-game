extends Topping
class_name Cheese

@export var shredded: bool = false

func _init(shredded_cheese: bool): 
	shredded = shredded_cheese

func _to_string() -> String:
	return "Cheese"

func repr():
	return "Cheese, shredded: " + str(shredded) + " "
