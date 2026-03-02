extends Node2D
class_name GameLevel

@export var game_info: GameInfo
@export var stations: Stations
@export var cashier_stations_node: CashierStations
@export var order_stations: OrderStations
@export var end_screen: EndScreen
@export var minute_timer: MinuteTimer
@export var list_of_ingredients: Array[Resource]
@export var cutscene: Cutscene


var order_currently_here: bool
const customer_scene = preload("res://scenes/entities/customer.tscn")
const truck_scene = preload("res://scenes/entities/truck.tscn")
var cashier_stations_array: Array
var cashier_stations: Dictionary
var rating: float = 0
var customers_served: int
var rating_sum: float
var tickets = {}
var hours: float
var minutes: int
var chance_of_customer: float
const seconds_per_hour: int = 60
var time_since_customer_came: int = 10
var wait_time = 10

func _ready() -> void:
	setup_game()

func setup_game():
	if not game_info or not stations or not cashier_stations_node \
	or not order_stations or not end_screen or not minute_timer or not list_of_ingredients:
		push_warning("Missing components on ", self, " Please check Inspector")
		queue_free()
		return
	game_info.time.set_time(int(hours), minutes)
	Global.list_of_ingredients = list_of_ingredients
	for station in order_stations.get_children():
		station.interact_component.OrderFood.connect(handle_truck)
	for ticket in game_info.tickets.get_children():
		ticket.visible = false
		tickets[ticket] = null
	for station in cashier_stations_node.get_children():
		cashier_stations_array.append(station)
		cashier_stations[station] = []
	minute_timer.timeout.connect(on_game_tick)

func on_game_tick():
	# -0.02353x^{2} + 0.21154x 
	time_since_customer_came += 1
	minutes += 1
	hours = minutes / 60.0
	# chance_of_customer = ( -0.02353 * hours * hours ) + (0.21154 * hours)
	chance_of_customer = 0.6
	game_info.time.set_time(int(hours), minutes)
	if hours >= 8:
		end_game()
	if randf() < chance_of_customer:
		if time_since_customer_came < wait_time:
			return
		time_since_customer_came = 0
		wait_time = 10 + randi_range(-2, 5)
		customer_incoming()

func customer_incoming():
	var customer = customer_scene.instantiate()
	var selected_station = cashier_stations_array.pick_random()
	for customer_array in cashier_stations.values():
		if len(customer_array) < len(cashier_stations[selected_station]):
			selected_station = cashier_stations.find_key(customer_array)
	customer.position = Vector2(-10, 324)
	customer.station = selected_station
	customer.CustomerLeft.connect(handle_customer_leaving)
	if len(cashier_stations[selected_station]) == 0:
		selected_station.extra_station_info = customer
	cashier_stations[selected_station].append(customer)
	customer.Order.connect(add_ticket_to_screen)
	add_child(customer)
	move_all_customers(selected_station)
	return customer

func move_all_customers(station):
	for index in range(len(cashier_stations[station])):
		var customer = cashier_stations[station][index]
		customer.target_position = station.position - (Vector2(50,0) * (index + 1))
		customer.move_to_position()

func handle_truck(item):
	game_info.ordering.order(item)
	if order_currently_here: return
	order_currently_here = true
	var truck = truck_scene.instantiate()
	truck.ingredient = item
	add_child(truck)
	await truck.tree_exited
	game_info.ordering.reset()

func find_customer_in_array(customer):
	for array in cashier_stations.values():
		if customer in array:
			return array

func handle_customer_leaving(customer):
	var ticket = tickets.find_key(customer)
	if not ticket:
		return
	ticket.remove_order()
	var customer_array = find_customer_in_array(customer)
	var station = cashier_stations.find_key(customer_array)
	move_all_customers(station)
	customer_array.erase(customer)
	if len(customer_array) >= 1:
		station.extra_station_info = customer_array[0]
	move_all_customers(station)
	if not Global.game_running:
		return 
	customers_served += 1
	rating_sum += customer.rating
	rating = rating_sum / customers_served
	rating = int(rating * 100) / 100.0
	game_info.current_rating.set_stars(rating)

func add_ticket_to_screen(customer, order):
	var next_avaliable_ticket
	for ticket in tickets.keys():
		if tickets[ticket] == null:
			next_avaliable_ticket = ticket
			break
	tickets[next_avaliable_ticket] = customer
	next_avaliable_ticket.set_order(order)

func end_game():
	end_screen.rating.set_rating(rating)
	Global.game_running = false
	minute_timer.stop()
	for player in Global.players:
		player.queue_free()
	Global.players = []
	for node in get_children():
		if node is Customer:
			node.queue_free()
	game_info.visible = false
	end_screen.visible = true
