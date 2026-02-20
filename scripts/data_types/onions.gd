extends Topping
class_name Onions

@export var chopped: bool
static var file_path = "res://assets/img/objects/onions/Onions.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func chop():
	chopped = true

func _to_string() -> String:
	return "Onions"

func repr():
	return "Onions, chopped: " + str(chopped) + " "
