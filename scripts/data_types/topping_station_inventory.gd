extends InventoryComponent
class_name ToppingStationInventoryComponent

var amount = 1

func _ready() -> void:
	push_warning(self.get_parent(), " has no value")

func add(item, a = 1):
	if not value:
		amount += a
		value = item
	if str(item) == str(value):
		amount += a

func get_amount():
	return amount

func subtract(_amount = 1):
	if amount == 0:
		return null
	amount -= _amount
	var temp = value
	return temp

func _to_string() -> String:
	return str(value) + " amount: " + str(amount)
