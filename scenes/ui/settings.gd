extends Control

@export var current_player: String

func _on_player_1_toggle_pressed() -> void:
	current_player = ""

func _on_player_2_toggle_pressed() -> void:
	current_player = "2"
