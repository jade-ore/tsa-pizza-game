extends Sprite2D
class_name Customer
signal CustomerLeft

enum {WAITING_TO_TALK, WAITING_FOR_ORDER}
@export var station: Node2D = null
@export var rating: int = 0
@export var target_position: Vector2
var current_state: int
var speed = 1
var order = Pizza.generate_pizza()
var order_taken: bool
var time_elapsed: int
var order_max_wait_time = 15
var serve_max_wait_time = 25
@export var patience = 10
var ready_to_talk: bool
signal Order

func _ready() -> void:
	while true:
		if station != null: break
	var tween = get_tree().create_tween()
	move_to_position()
	tween.tween_callback(start)

func move_to_position(_speed = 0):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position, speed)
	current_state = WAITING_TO_TALK

func start():
	$ElapsedTimeTimer.start()
	ready_to_talk = true

func interact(plr_inventory):
	if not ready_to_talk: return
	if not order_taken:
		var order_time_stars = remap(order_max_wait_time - time_elapsed + patience, 0, order_max_wait_time + patience, 0, 1)
		rating += round(order_time_stars)
		order_taken = true
		Order.emit(self, order)
		time_elapsed = 0
		current_state = WAITING_FOR_ORDER
		return
	if plr_inventory.value is not Pizza: 
		return
	var pizza = plr_inventory.subtract()
	rating += order.compare_to(pizza)
	var serve_time_stars = remap(serve_max_wait_time - time_elapsed + patience, 0, serve_max_wait_time + patience, 0, 1)
	rating += round(serve_time_stars)
	leave()

func stop_timer():
	$ElapsedTimeTimer.stop()
	time_elapsed = 0

func start_timer():
	$ElapsedTimeTimer.start()

func leave() -> void:
	rating = ( rating + abs(rating) ) / 2 # If rating is below 0, sets it to 0
	CustomerLeft.emit(self)
	print(rating)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(0,348), speed)
	await tween.finished
	queue_free()

func one_second_passed() -> void:
	time_elapsed += 1
	if current_state == WAITING_TO_TALK:
		if time_elapsed > order_max_wait_time + patience: 
			rating = 0
			leave()
	if current_state == WAITING_FOR_ORDER:
		if time_elapsed > serve_max_wait_time + patience: 
			rating = 0
			leave()
