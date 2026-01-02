extends Control

func _ready() -> void:
	for button in $HFlowContainer.get_children():
		button.pressed.connect(button_pressed.bind(button))
		button.text = str(button.name)

func button_pressed(button: Button):
	if int(button.name):
		Global.level = int(button.name)
		get_tree().change_scene_to_file("res://scenes/main_game.tscn")
	else:
		push_warning("Button name must be a number!")
