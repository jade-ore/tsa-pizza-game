extends Topping
class_name Sauce

static var normal = load("res://assets/img/objects/sauce/sauce_normal.png")
static var selected = load("res://assets/img/objects/sauce/sauce_selected.png")

func _to_string() -> String:
	return "Sauce"

func repr():
	return "Sauce"
