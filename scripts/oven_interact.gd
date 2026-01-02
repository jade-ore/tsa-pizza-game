extends InteractComponent

@export var inventory: InventoryComponent
@export var TIME_TO_COOK: float = 30 # seconds
var is_cooking_food: bool = false
var pizza: Pizza

func _ready() -> void:
	$"../CookTimer".wait_time = TIME_TO_COOK

func run(plr_inventory: InventoryComponent):
	if inventory.value == null:
		oven_cook(plr_inventory)
		return
	pizza = null
	$"../CookTimer".stop()
	$"../Control/Label".text = "Oven"
	plr_inventory.add(inventory.subtract())
	
func oven_cook(plr_inventory: InventoryComponent):
	if not plr_inventory.value is Pizza:
		return
	$"../Control/Label".text = "Cooking..."
	pizza = plr_inventory.subtract() as Pizza 
	$"../CookTimer".start()
	inventory.add(pizza)


func _on_cook_timer_timeout() -> void:
	pizza.cook()
	$"../Control/Label".text = "Finished!"
