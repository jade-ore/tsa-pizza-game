extends Control

func _ready() -> void:
	for button in $HFlowContainer.get_children():
		button.pressed.connect(button_pressed.bind(button))
		button.text = str(button.name)

func button_pressed(button: Button):
	if int(button.name):
		Global.level = int(button.name)
		var main_game = get_tree().change_scene_to_file("res://scenes/main_game.tscn")
	else:
		push_warning("Button name must be a number!")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/home_screen.tscn")
