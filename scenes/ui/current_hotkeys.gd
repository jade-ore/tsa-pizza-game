extends VBoxContainer

var empty_label_array: Array

func _process(delta: float) -> void:
	for label in self.get_children():
		var input_event = InputMap.action_get_events(label.name + $"..".current_player)
		if input_event.is_empty():
			label.text = ""
			return
		label.text = input_event[0].as_text_physical_keycode()
