extends InteractComponent

var customer_at_cashier: Node2D = null
var order: Pizza

func _process(delta: float) -> void:
	call_deferred("find_customer")

func find_customer():
	if $"..".extra_station_info:
		customer_at_cashier = $"..".extra_station_info 

func run(inventory):
	if not customer_at_cashier:
		return
	customer_at_cashier.interact(inventory)
