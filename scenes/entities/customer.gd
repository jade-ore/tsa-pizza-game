extends Sprite2D
signal CustomerLeft

@export var station: Node2D = null
@export var rating: int
var order = Pizza.generate_pizza()
var order_taken: bool
var time_elapsed: int
var max_wait_time = 25

# Start a timer, divide timer into 5 sections, stars go down after cutoff until order taken
# Take order, have it show up at bottom of screen
# Start a timer, divide timer into 5 sections, stars go down after cutoff pizza given
# Customer leaves

func _ready() -> void:
	while true:
		if station != null:
			break
	global_position = station.position - Vector2(50, 0)
	$ElapsedTimeTimer.start()

func interact(pizza):
	"""
	Check if order is taken already
	If it is not, map time waited to 5 star rating
	If it is, check how many ingredients got right in pizza and grab a percentage, multiply by 5 and floor
	Check time waited and map time to 5 star rating also
	Call a leave function that leaves
	"""
	if not order_taken:
		# Maps the time elapsed to amount of stars
		var stars = remap(max_wait_time - time_elapsed, 0, max_wait_time, 0, 5)
		rating += floor(stars) + 1
		"""Take order"""
		return
	

func _exit_tree() -> void:
	CustomerLeft.emit(self)

func one_second_passed() -> void:
	time_elapsed += 1
