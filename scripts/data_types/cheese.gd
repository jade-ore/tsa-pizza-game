extends Topping
class_name Cheese

@export var shredded: bool = false

static var file_path = "res://assets/img/objects/cheese/Cheese.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _init(shredded_cheese: bool): 
	shredded = shredded_cheese

func _to_string() -> String:
	return "Cheese"

func repr():
	return "Cheese, shredded: " + str(shredded) + " "
