extends Node2D

const customer_scene = preload("res://scenes/entities/customer.tscn")
@onready var open_stations = $CashierStations.get_children()
var wait_time = $CustomerTimer.wait_time

func _ready() -> void:
	var max_wait_time = 25
	var waited_time = 4
	var stars = remap(max_wait_time - waited_time, 0, max_wait_time, 0, 5)
	print(floor(stars) + 1)
	$CustomerTimer.start()

func _process(delta: float) -> void:
	if $CustomerTimer.is_stopped() and len(open_stations) != 0:
		$CustomerTimer.start(randi_range(0, 5))

func customer_incoming():
	print("customer_came")
	var customer = customer_scene.instantiate()
	var selected_station = open_stations.pick_random()
	open_stations.erase(selected_station)
	customer.station = selected_station
	customer.CustomerLeft.connect(handle_customer_leaving)
	add_child(customer)
	if len(open_stations) != 0:
		$CustomerTimer.start(wait_time + randi_range(0, 5))

func handle_customer_leaving(customer):
	# Open up station again
	# Add rating to average
	print(customer, " left")
