extends Topping
class_name Sausage

@export var package_opened: bool
static var normal = load("res://assets/img/objects/sausage/sausage_normal.png")
static var selected = load("res://assets/img/objects/sausage/sausage_selected.png")

func _init(package_opened_input: bool) -> void:
	package_opened = package_opened_input

func open_package():
	package_opened = true

func _to_string() -> String:
	return "Sausage"

func repr():
	return "Sausage, package opened: " + str(package_opened) + " "
