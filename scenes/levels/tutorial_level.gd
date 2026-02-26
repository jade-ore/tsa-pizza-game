extends GameLevel

var pos_array_index: int = 0
var original_pos: Array
var total_stations: Array
var next_step: bool

signal Continue

var cutscene_1 = [
	["Tutorial", "Welcome to the game!"],
	["Tutorial", "I will be the person teaching you all of the controls and how to play the game."],
	["Tutorial", "First, we will look at the movement controls."],
	["Tutorial", "The way you move is by using your WASD keys, and for the player on the right, IJKL."],
	["Tutorial", "Try moving around right now!"],
	["End"]
]
var cutscene_2 = [
	["Tutorial", "To make a pizza, go to the dough station and click E"],
	["Tutorial", "Then, use your A and D keys to select which size dough you want."],
	["End"]
]
var cutscene_3 = [
	["Tutorial", "Then, to roll the dough, click E again."],
	["End"]
]
var cutscene_4 = [
	["Tutorial", "Let's also introduce something else."],
	["ChangePositionMiddle"],
	["End"]
]
var cutscene_5 = [
	["Tutorial", "These are your inventory squares."],
	["Tutorial", "They will show you what you currently have in your inventory."],
	["ChangePositionHome"],
	["End"]
]
var cutscene_6 = [
	["Tutorial", "Next, we will learn how to add ingredients onto our pizza."],
	["End"]
]

func _ready() -> void:
	setup_game()
	minute_timer.stop()
	for child in game_info.get_children():
		if not child.name == "Background":
			child.visible = false
	for child in stations.get_children():
		original_pos.append(child.position)
		total_stations.append(child)
		child.position = Vector2(-99999, 88888)
	for child in cashier_stations_node.get_children():
		original_pos.append(child.position)
		total_stations.append(child)
		child.position = Vector2(-99999, 88888)
	for child in order_stations.get_children():
		original_pos.append(child.position)
		total_stations.append(child)
		child.position = Vector2(-99999, 88888)
	
	
	cutscene.set_dialogue(cutscene_1)
	cutscene.next_scene()
	
	await cutscene.finished
	await get_tree().create_timer(1).timeout
	
	show_next_station()
	$Stations/Dough.interact_component.inventory.amount = 9999999
	cutscene.set_dialogue(cutscene_2)
	cutscene.next_scene()
	await cutscene.finished
	await Global.players[0].TutorialPass
	cutscene.set_dialogue(cutscene_3)
	cutscene.next_scene()
	await cutscene.finished
	await Global.players[0].TutorialPass
	
	cutscene.set_dialogue(cutscene_4)
	cutscene.next_scene()
	await cutscene.finished
	await get_tree().process_frame
	cutscene.set_dialogue(cutscene_5)
	cutscene.next_scene()
	game_info.inventory.visible = true
	show_next_station(2)
	$Stations/Cheese.interact_component.inventory.amount = 999999
	$Stations/Sauce.interact_component.inventory.amount = 999999
func player_passed():
	Continue.emit()

func show_next_station(_amount: int = 1):
	for i in range(_amount):
		total_stations[pos_array_index].position = original_pos[pos_array_index]
		pos_array_index += 1
