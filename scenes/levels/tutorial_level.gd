extends GameLevel

var pos_array_index: int = 0
var original_pos: Array
var total_stations: Array
var current_step: int

enum {
	ADD_INGREDIENTS,
	NOTHING,
	COOK_PIZZA,
	USE_TABLES,
	USE_INGREDIENTS,
}

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
	["Tutorial", "To make a pizza, you first interact with the dough station."],
	["Tutorial", "To interact with something, go up to the station until it's highlighted in black, then click E or O"],
	["Tutorial", "Then, use your left and right movement keys (A and D for player on the left) to select which size dough you want."],
	["Tutorial", "Go ahead and grab some dough right now."],
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
	["Tutorial", "To add an ingredient onto our pizza, go and interact with an ingredient station with the rolled dough."],
	["Tutorial", "Go ahead and add sauce and cheese to our pizza."],
	["End"]
]
var cutscene_7 = [
	["Tutorial", "Now that we have our pizza, lets go ahead and go cook it."],
	["Tutorial", "If you have a pizza in your inventory, you can go and interact with the oven to put it inside the oven."],
	["Tutorial", 'Then, wait until the oven says "Finished!" and go up and interact with it again'],
	["End"]
]
var cutscene_8 = [
	["Tutorial", "Let's introduce something else."],
	["Tutorial", "Look at these empty tables."],
	["Tutorial", "Here, you can place items to do other things."],
	["Tutorial", "To place the items, go ahead and interact with the table."],
	["End"]
]
var cutscene_9 = [
	["Tutorial", "Here are the cashier stations."],
	["Tutorial", "Customers will show up."],
	["Tutorial", "To take an order for a customer, go up to the cashier station they're in front of and interact with it."],
	["Tutorial", "Go ahead and take the order right now!"],
	["End"]
]

var cutscene_10 = [
	["ChangePositionMiddle"],
	["Tutorial", "When you take an order, a ticket will pop up, shown here."],
	["ChangePositionHome"],
	["Tutorial", "To give a customer an order, have the pizza in your inventory and interact with the cashier station."],
	["End"]
]

var cutscene_11 = [
	["Tutorial", "Let's learn another new topic."],
	["Tutorial", "As you can see, numbers have popped up on the stations."],
	["Tutorial", "The numbers show the stock and how much is left."],
	["Tutorial", "Keep playing the game as you would normally."],
	["End"]
]
var cutscene_12 = [
	["Tutorial", "It looks like you're running out of ingredients."],
	["End"]
]
var cutscene_13 = [
	["Tutorial", "Here is the order station."],
	["Tutorial", "You can order more ingredients by selecting the ingredient you have to order."],
	["Tutorial", "If you accidentally click on it, click Q (left person) or U (right person) to exit."],
	["Tutorial", "Try ordering now!"],
	["End"]
]

var cutscene_14 = [
	["Tutorial", "Now that you have ordered ingredients, a package has been delivered."],
	["Tutorial", "To unpack the delivery, you take the ingredient from the package, and you put it back into the station by interacting with the station."],
	["Tutorial", "    dGo ahead and unpack the entire package now."],
	["End"]
]

var cutscene_15 = [
	["Tutorial", "Finally, let's introduce stars."],
	["Tutorial", "Customers will give you a rating out of 5 based on how fast you take their order, how accurate your pizza is, and how fast you get them the pizza."],
	["Tutorial", "Play until it is 8 o'clock!"],
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
	
	# intro
	cutscene.set_dialogue(cutscene_1)
	cutscene.next_scene()
	
	await cutscene.finished
	await get_tree().create_timer(1).timeout
	
	# get dough
	show_next_station()
	$Stations/Dough.interact_component.inventory.amount = 9999999
	cutscene.set_dialogue(cutscene_2)
	cutscene.next_scene()
	await Global.players[0].TutorialPass
	
	# roll dough
	cutscene.set_dialogue(cutscene_3)
	cutscene.next_scene()
	
	await Global.players[0].TutorialPass
	
	# inventory
	cutscene.set_dialogue(cutscene_4)
	cutscene.next_scene()
	await cutscene.finished
	await get_tree().process_frame
	cutscene.set_dialogue(cutscene_5)
	cutscene.next_scene()
	game_info.inventory.visible = true
	await cutscene.finished
	await get_tree().process_frame
	
	# toppings
	cutscene.set_dialogue(cutscene_6)
	cutscene.next_scene()
	show_next_station(2)
	$Stations/Cheese.interact_component.inventory.amount = 999999
	$Stations/Sauce.interact_component.inventory.amount = 999999
	current_step = ADD_INGREDIENTS
	await NextStep
	
	# use oven
	current_step = NOTHING
	cutscene.set_dialogue(cutscene_7)
	cutscene.next_scene()
	show_next_station()
	current_step = COOK_PIZZA
	await NextStep
	
	current_step = NOTHING
	# use empty tables
	cutscene.set_dialogue(cutscene_8)
	cutscene.next_scene()
	show_next_station(4)
	current_step = USE_TABLES
	await NextStep
	
	# cashiers
	show_next_station()
	var customer = customer_incoming()
	cutscene.set_dialogue(cutscene_9)
	cutscene.next_scene()
	customer.stop_timer()
	await customer.Order
	
	# tickets and customer
	$GameInfo/TicketsContainer.visible = true
	cutscene.set_dialogue(cutscene_10)
	cutscene.next_scene()
	await cutscene.finished
	await customer.CustomerLeft
	
	# stock
	$Stations/Cheese.interact_component.inventory.amount = 5
	$Stations/Sauce.interact_component.inventory.amount = 5
	$Stations/Dough.interact_component.inventory.amount = 5
	cutscene.set_dialogue(cutscene_11)
	cutscene.next_scene()
	await cutscene.finished
	current_step = USE_INGREDIENTS
	minute_timer.start()
	await NextStep
	
	# ordering
	current_step = NOTHING
	cutscene.set_dialogue(cutscene_12)
	cutscene.next_scene()
	show_next_station()
	await cutscene.finished
	await get_tree().process_frame
	cutscene.set_dialogue(cutscene_13)
	cutscene.next_scene()
	await cutscene.finished
	await Global.players[0].Order
	
	# unpack package
	var package: Package = null
	cutscene.set_dialogue(cutscene_14)
	cutscene.next_scene()
	await cutscene.finished
	while not package:
		for child in get_children():
			if child is Package:
				package = child
				break
		await get_tree().process_frame
	await package.tree_exiting
	
	# rating to end
	minute_timer.stop()
	cutscene.set_dialogue(cutscene_15)
	cutscene.next_scene()
	await cutscene.finished
	minute_timer.start()
	game_info.time.visible = true
	game_info.current_rating.visible = true

signal NextStep
func _process(delta: float) -> void:
	if not Global.players[0]:
		return
	var player_pizza = Global.players[0].inventory.value
	if current_step == ADD_INGREDIENTS:
		if Global.players[0].inventory.value is not Pizza:
			return
		if len(player_pizza.toppings) == 2:
			NextStep.emit()
	if current_step == COOK_PIZZA:
		if Global.players[0].inventory.value is not Pizza:
			return
		if player_pizza.cooked == 1:
			NextStep.emit()
	if current_step == USE_TABLES:
		if Global.players[0].inventory.value == null:
			NextStep.emit()
	if current_step == USE_INGREDIENTS:
		if $Stations/Cheese.interact_component.inventory.amount ==  1: NextStep.emit()
		if $Stations/Dough.interact_component.inventory.amount ==  1: NextStep.emit()
		if $Stations/Sauce.interact_component.inventory.amount ==  1: NextStep.emit()

func player_passed():
	Continue.emit()

func show_next_station(_amount: int = 1):
	for i in range(_amount):
		total_stations[pos_array_index].position = original_pos[pos_array_index]
		pos_array_index += 1
