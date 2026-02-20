extends Topping
class_name Sauce

static var file_path = "res://assets/img/objects/sauce/Sauce.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _to_string() -> String:
	return "Sauce"

func repr():
	return "Sauce"
