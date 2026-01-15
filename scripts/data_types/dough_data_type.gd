extends Topping
class_name Dough

@export var rolled: bool
static var normal = load("res://assets/img/objects/dough/dough_normal.png")
static var selected = load("res://assets/img/objects/dough/dough_selected.png")
static var Class = "Dough"

func _to_string() -> String:
	return "Dough"
