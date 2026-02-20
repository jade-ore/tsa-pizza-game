extends Topping
class_name Dough

@export var rollable: bool
@export var size: int

static var file_path = "res://assets/img/objects/dough/Dough.png"
static var normal = get_normal_from_file(file_path)
static var selected = get_selected_from_file(file_path)

func _init(_rollable: bool, _size: int = 0) -> void:
	rollable = _rollable
	size = _size

func _to_string() -> String:
	return "Dough"
