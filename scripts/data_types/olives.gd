extends Topping
class_name Olives

@export var open: bool

static var file_path = "res://assets/img/objects/olives/Olives.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _init(open_input: bool) -> void:
	open = open_input

func open_can():
	open = true

func _to_string() -> String:
	return "Olives"
