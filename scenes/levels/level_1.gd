extends Node2D

const customer_scene = preload("res://scenes/entities/customer.tscn")
const truck_scene = preload("res://scenes/entities/truck.tscn")
@onready var open_stations = $CashierStations.get_children()
var closed_stations = {}
var wait_time = $CustomerTimer.wait_time
var list_of_ingredients = [Dough, Sauce, Cheese, Onions, Sausage, Pepperoni, Olives, Mushrooms]
@export var order_currently_here: bool

func _ready() -> void:
	print("\n\n\n\n\n\n\n\n")
	Global.list_of_ingredients = list_of_ingredients
	for station in $OrderStations.get_children():
		station.interact_component.OrderFood.connect(handle_truck)
	$CustomerTimer.start()

func _process(delta: float) -> void:
	if $CustomerTimer.is_stopped() and len(open_stations) != 0:
		$CustomerTimer.start(randi_range(0, 5) + wait_time)

func customer_incoming():
	var customer = customer_scene.instantiate()
	var selected_station = open_stations.pick_random()
	customer.position = Vector2(-10, 324)
	open_stations.erase(selected_station)
	customer.station = selected_station
	customer.CustomerLeft.connect(handle_customer_leaving)
	closed_stations[customer] = selected_station
	selected_station.extra_station_info = customer
	add_child(customer)
	if len(open_stations) != 0:
		$CustomerTimer.start(wait_time + randi_range(0, 5))

func handle_truck(item):
	if order_currently_here: return
	order_currently_here = true
	var truck = truck_scene.instantiate()
	truck.ingredient = item
	add_child(truck)

func handle_customer_leaving(customer):
	# Open up station again
	# Add rating to average
	open_stations.append(closed_stations[customer])
	closed_stations[customer].extra_station_info = null
	closed_stations.erase(customer)
