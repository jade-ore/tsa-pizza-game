extends Topping
class_name Onions

@export var chopped: bool

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func chop():
	chopped = true

func _to_string() -> String:
	return "Onions, chopped: " + str(chopped)
