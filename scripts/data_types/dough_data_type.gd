extends Topping
class_name Dough

@export var rolled: bool

func _to_string() -> String:
	return "Dough, rolled: " + str(rolled)
