extends Topping
class_name Olives

@export var open: bool

func _init(open_input: bool) -> void:
	open = open_input

func open_can():
	open = true

func _to_string() -> String:
	return "Olives"
