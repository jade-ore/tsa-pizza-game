extends Topping
class_name Onions

@export var chopped: bool

static var normal = load("res://assets/img/objects/onions/onions_normal.png")
static var selected = load("res://assets/img/objects/onions/onions_selected.png")

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func chop():
	chopped = true

func _to_string() -> String:
	return "Onions"

func repr():
	return "Onions, chopped: " + str(chopped) + " "
