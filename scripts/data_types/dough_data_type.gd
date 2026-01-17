extends Topping
class_name Dough

@export var rollable: bool
static var normal = load("res://assets/img/objects/dough/dough_normal.png")
static var selected = load("res://assets/img/objects/dough/dough_selected.png")
static var Class = "Dough"

func _init(input: bool) -> void:
	rollable = input

func _to_string() -> String:
	return "Dough"
