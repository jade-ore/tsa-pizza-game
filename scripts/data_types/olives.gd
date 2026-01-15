extends Topping
class_name Olives

@export var open: bool

static var normal = load("res://assets/img/objects/olives/olives_normal.png")
static var selected = load("res://assets/img/objects/olives/olives_selected.png")

func _init(open_input: bool) -> void:
	open = open_input

func open_can():
	open = true

func _to_string() -> String:
	return "Olives"
