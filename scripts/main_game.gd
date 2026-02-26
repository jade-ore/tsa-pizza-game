extends Node2D

const starting_string: String = "res://scenes/levels/level_"
const player1_scene = preload("res://scenes/entities/player.tscn")
const player2_scene = preload("res://scenes/entities/player2.tscn")

func _ready() -> void:
	var level_path = starting_string + str(Global.level) + ".tscn"
	if Global.level == -1:
		level_path = "res://scenes/levels/tutorial_level.tscn"
	var level = load(level_path).instantiate()
	var player1 = player1_scene.instantiate() as Player
	var player2 = player2_scene.instantiate() as Player
	Global.players = [player1, player2]
	player1.interact.connect(_on_player1_interact)
	player2.interact.connect(_on_player2_interact)
	add_child(level)
	add_child(player1)
	# add_child(player2)
	for player in Global.players:
		player.prepare_menus()
		player.position = Vector2(728.0, 322.0)

func _on_player1_interact(inventory) -> void:
	if not Global.selected_station1:
		return
	Global.selected_station1.interact(inventory)

func _on_player2_interact(inventory) -> void:
	if not Global.selected_station2:
		return
	Global.selected_station2.interact(inventory)
