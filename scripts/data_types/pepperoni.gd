extends Topping
class_name Pepperoni

@export var sliced: bool
static var file_path = "res://assets/img/objects/pepporoni/Pepperoni.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)
func _init(slice_input: bool):
	sliced = slice_input
	
func _to_string() -> String:
	return "Pepporoni"

func slice():
	sliced = true

func repr():
	return "Pepperoni, sliced: " + str(sliced) + " "
