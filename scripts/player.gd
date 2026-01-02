extends CharacterBody2D
signal interact
enum Movement {RIGHT, LEFT, UP, DOWN}

var movement_direction: Vector2
var speed: int = 500
var facing_direction = 0
var last_direction: Vector2
var is_rolling_dough: bool

@export var inventory: InventoryComponent
@export var time_it_takes_to_roll_dough: float = 2

func _ready() -> void:
	print("")


func _physics_process(delta: float) -> void:
	movement_direction = Input.get_vector('left', 'right', 'up', 'down')
	velocity = movement_direction * speed
	check_input()
	find_facing_direction()
	animate()
	move_and_slide()
	last_direction = round(movement_direction)

func check_input():
	if Input.is_action_just_pressed("interact"):
		if await roll_dough():
			return
		interact.emit(inventory)


func animate():
	$"../CanvasLayer/Label".text = "Player 1 items: " + str(inventory)
	$AnimatedSprite2D.frame = facing_direction
	for label in $Control.get_children():
		label.visible = false
	if inventory.value is Dough:
		$Control/ClickEToRoll.visible = true
	elif is_rolling_dough:
		$Control/Label.visible = true

func get_direction():
	return facing_direction

func find_facing_direction():
	var rounded_movement_direction_x = round(movement_direction.x)
	var rounded_movement_direction_y = round(movement_direction.y)
	#
	# Check if X direction changed
	if last_direction.x != rounded_movement_direction_x:
		if rounded_movement_direction_x == 1:
			facing_direction = Movement.RIGHT
		if rounded_movement_direction_x == -1:
			facing_direction = Movement.LEFT
	#
	# Check if Y direction changed
	if last_direction.y != rounded_movement_direction_y:
		if rounded_movement_direction_y == -1:
			facing_direction = Movement.UP
		if rounded_movement_direction_y == 1:
			facing_direction = Movement.DOWN
	#
	# Check if only one direction is active
	if abs(rounded_movement_direction_x) + abs(rounded_movement_direction_y) == 1:
		if rounded_movement_direction_x == 1:
			facing_direction = Movement.RIGHT
		if rounded_movement_direction_x == -1:
			facing_direction = Movement.LEFT
		if rounded_movement_direction_y == -1:
			facing_direction = Movement.UP
		if rounded_movement_direction_y == 1:
			facing_direction = Movement.DOWN

func roll_dough():
	if not inventory.value is Dough:
		return false
	var timer = get_tree().create_timer(time_it_takes_to_roll_dough)
	var subtracted = inventory.subtract()
	is_rolling_dough = true
	await timer.timeout
	inventory.add(Pizza.new())
	is_rolling_dough = false
	return true
