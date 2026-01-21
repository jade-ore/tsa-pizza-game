extends Topping
class_name Dough

@export var rollable: bool
@export var size: int
static var normal = load("res://assets/img/objects/dough/dough_normal.png")
static var selected = load("res://assets/img/objects/dough/dough_selected.png")
static var Class = "Dough"

func _init(_rollable: bool, _size: int = 0) -> void:
	rollable = _rollable
	size = _size

func _to_string() -> String:
	return "Dough"
