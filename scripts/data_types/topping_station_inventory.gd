extends InventoryComponent
class_name ToppingStationInventoryComponent

var amount = 1

func _ready() -> void:
	value = Dough.new(true)

func add(item, a = 1):
	if not value:
		amount += a
		value = item
	if str(item) == str(value):
		amount += a

func get_amount():
	return amount

func subtract():
	amount -= 1
	var temp = value
	if amount == 0:
		value = null
	return temp

func _to_string() -> String:
	return str(value) + " amount: " + str(amount)
