extends Sprite2D
signal CustomerLeft

@export var station: Node2D = null
@export var rating: int = 0
var order = Pizza.generate_pizza()
var order_taken: bool
var time_elapsed: int
var order_max_wait_time = 25
var serve_max_wait_time = 50
var patience = 10
var ready_to_talk: bool
signal Order

func _ready() -> void:
	while true:
		if station != null: break
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", station.position - Vector2(50, 0), ceil(randf() * 4))
	tween.tween_callback(start)

func start():
	$ElapsedTimeTimer.start()
	ready_to_talk = true

func interact(plr_inventory):
	if not ready_to_talk: return
	if not order_taken:
		var order_time_stars = remap(order_max_wait_time - time_elapsed + patience, 0, order_max_wait_time + patience, 0, 5)
		rating += round(order_time_stars)
		order_taken = true
		Order.emit(self, order)
		time_elapsed = 0
		return
	if plr_inventory.value is not Pizza: 
		return
	var pizza = plr_inventory.subtract()
	rating += order.compare_to(pizza)
	var serve_time_stars = remap(serve_max_wait_time - time_elapsed + patience, 0, serve_max_wait_time + patience, 0, 5)
	rating += round(serve_time_stars)
	queue_free()

func _exit_tree() -> void:
	rating = ( rating + abs(rating) ) / 2 # If rating is below 0, sets it to 0
	rating /= 3 # Find the average rating
	print("I give you %s stars" % rating)
	CustomerLeft.emit(self)

func one_second_passed() -> void:
	time_elapsed += 1
