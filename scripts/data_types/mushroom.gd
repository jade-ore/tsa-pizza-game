extends Topping
class_name Mushrooms

@export var chopped: bool

static var file_path = "res://assets/img/objects/mushrooms/Mushrooms.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _init(chopped_input: bool) -> void:
	chopped = chopped_input

func _to_string() -> String:
	return "Mushroom"

func chop():
	chopped = true
