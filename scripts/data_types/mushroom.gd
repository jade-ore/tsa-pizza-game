extends Topping
class_name Mushrooms

@export var chopped: bool

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func _to_string() -> String:
	return "Mushroom, chopped: " + str(chopped)

func chop():
	chopped = true
