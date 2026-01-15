extends Topping
class_name Pepperoni

@export var sliced: bool

static var normal = load("res://assets/img/objects/pepporoni/pepperoni_normal.png")
static var selected = load("res://assets/img/objects/pepporoni/pepperoni_selected.png")

func _init(slice_input: bool):
	sliced = slice_input
	
func _to_string() -> String:
	return "Pepporoni"

func slice():
	sliced = true

func repr():
	return "Pepperoni, sliced: " + str(sliced) + " "
