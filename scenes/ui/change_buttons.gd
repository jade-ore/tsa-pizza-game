extends VBoxContainer
signal EmptyKey

var changing_action = null
var used_keys: Dictionary

func _ready() -> void:
	for button in self.get_children():
		button.pressed.connect(update_key.bind(button.name))
		used_keys[button.name + $"..".current_player] = InputMap.action_get_events(button.name)[0].as_text_physical_keycode()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and changing_action:
		if event.as_text_physical_keycode() in used_keys.values():
			var action = used_keys.find_key(event.as_text_physical_keycode())
			InputMap.action_erase_events(action)
			EmptyKey.emit(action)
			used_keys[action] = ""
		InputMap.action_add_event(changing_action, event)
		used_keys[changing_action] = event.as_text_physical_keycode()
		changing_action = null

func update_key(action):
	InputMap.action_erase_events(action + $"..".current_player)
	changing_action = action + $"..".current_player
