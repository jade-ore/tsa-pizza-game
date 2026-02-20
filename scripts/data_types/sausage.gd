extends Topping
class_name Sausage

@export var package_opened: bool

static var file_path = "res://assets/img/objects/sausage/Sausage.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)
func _init(package_opened_input: bool) -> void:
	package_opened = package_opened_input

func open_package():
	package_opened = true

func _to_string() -> String:
	return "Sausage"

func repr():
	return "Sausage, package opened: " + str(package_opened) + " "
