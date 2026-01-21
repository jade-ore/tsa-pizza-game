extends Node2D

const customer_scene = preload("res://scenes/entities/customer.tscn")
const truck_scene = preload("res://scenes/entities/truck.tscn")
var cashier_stations_array: Array
var cashier_stations: Dictionary
var wait_time = $CustomerTimer.wait_time
var list_of_ingredients = [Dough, Sauce, Cheese, Onions, Sausage, Pepperoni, Olives, Mushrooms]
@export var order_currently_here: bool
var rating: float = 5
var customers_served: int
var rating_sum: float
var tickets = {}
var hours: float
var minutes: int
var chance_of_customer: float
var seconds_per_hour: int = 60
var time_since_customer_came: int = 10
var time_to_wait_until_next = 10

func _ready() -> void:
	print("\n\n\n\n\n\n\n\n")
	$GameInfo/Time.set_time(hours, minutes)
	Global.list_of_ingredients = list_of_ingredients
	for station in $OrderStations.get_children():
		station.interact_component.OrderFood.connect(handle_truck)
	for ticket in $GameInfo/TicketsContainer.get_children():
		ticket.visible = false
		tickets[ticket] = null
	for station in $CashierStations.get_children():
		cashier_stations_array.append(station)
		cashier_stations[station] = []

func on_game_tick():
	# -0.02353x^{2} + 0.21154x 
	time_since_customer_came += 1
	minutes += 1
	hours = minutes / 60.0
	chance_of_customer = ( -0.02353 * hours * hours ) + (0.21154 * hours)
	$GameInfo/Time.set_time(int(hours), minutes)
	if randf() < chance_of_customer:
		if time_since_customer_came < time_to_wait_until_next:
			return
		time_since_customer_came = 0
		time_to_wait_until_next = 10 + randi_range(-2, 5)
		customer_incoming()

func customer_incoming():
	var customer = customer_scene.instantiate()
	var selected_station = cashier_stations_array.pick_random()
	for customer_array in cashier_stations.values():
		if len(customer_array) < len(cashier_stations[selected_station]):
			selected_station = cashier_stations.find_key(customer_array)
	customer.position = Vector2(-10, 324)
	cashier_stations[selected_station].append(customer)
	customer.station = selected_station
	customer.CustomerLeft.connect(handle_customer_leaving)
	selected_station.extra_station_info = customer
	customer.Order.connect(add_ticket_to_screen)
	add_child(customer)

func handle_truck(item):
	$GameInfo/Ordering.order(item)
	if order_currently_here: return
	order_currently_here = true
	var truck = truck_scene.instantiate()
	truck.ingredient = item
	
	add_child(truck)
	await truck.tree_exited
	$GameInfo/Ordering.reset()

func handle_customer_leaving(customer):
	var ticket = tickets.find_key(customer)
	if not ticket:
		return
	ticket.remove_order()
	customers_served += 1
	rating_sum += customer.rating
	rating = rating_sum / customers_served
	$GameInfo/Rating.set_rating(rating)
	print(rating)

func add_ticket_to_screen(customer, order):
	var next_avaliable_ticket
	for ticket in tickets.keys():
		if tickets[ticket] == null:
			next_avaliable_ticket = ticket
			break
	tickets[next_avaliable_ticket] = customer
	next_avaliable_ticket.set_order(order)
