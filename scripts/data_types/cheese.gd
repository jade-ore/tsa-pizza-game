extends Topping
class_name Cheese

@export var shredded: bool = false

static var normal = load("res://assets/img/objects/cheese/cheese_normal.png")
static var selected = load("res://assets/img/objects/cheese/cheese_selected.png")

func _init(shredded_cheese: bool): 
	shredded = shredded_cheese

func _to_string() -> String:
	return "Cheese"

func repr():
	return "Cheese, shredded: " + str(shredded) + " "
