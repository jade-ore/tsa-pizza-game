extends ColorRect
class_name BoxWithText
@export var label: Label

func _ready() -> void:
	if label == null:
		for child in self.get_children():
			if child is Label:
				label = child
				return
		push_warning("No label for box with text (ultimate abstraction)")
