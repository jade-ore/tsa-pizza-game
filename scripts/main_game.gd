extends Node2D

const starting_string: String = "res://scenes/levels/level_"

func _ready() -> void:
	var level_path = starting_string + str(1) + ".tscn"
	var level = load(level_path).instantiate()
	add_child(level)

func _on_player_interact(inventory) -> void:
	if not Global.selected_station:
		return
	Global.selected_station.interact(inventory)
