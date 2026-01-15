extends Topping
class_name Mushrooms

@export var chopped: bool

static var normal = load("res://assets/img/objects/mushrooms/mushrooms_normal.png")
static var selected = load("res://assets/img/objects/mushrooms/mushrooms_selected.png")

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func _to_string() -> String:
	return "Mushroom"

func chop():
	chopped = true
