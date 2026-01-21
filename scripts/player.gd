extends CharacterBody2D
class_name Player
signal interact
enum Movement {RIGHT, LEFT, UP, DOWN}

var movement_direction: Vector2
var speed: int = 500
var facing_direction = 0
var last_direction: Vector2
var current_menu: String = ""

@export var inventory: InventoryComponent
@export var time_it_takes_to_roll_dough: float = 2

func _physics_process(delta: float) -> void:
	movement_direction = Input.get_vector('left', 'right', 'up', 'down')
	if not menu_running:
		velocity = movement_direction * speed
		find_facing_direction()
	animate()
	move_and_slide()
	last_direction = round(movement_direction)

func _input(_event: InputEvent) -> void:
	if menu_running:
		if Input.is_action_just_pressed("down"):
			change_menu(menu_vector_directions[Movement.DOWN])
		if Input.is_action_just_pressed("up"):
			change_menu(menu_vector_directions[Movement.UP])
		if Input.is_action_just_pressed("right"):
			change_menu(menu_vector_directions[Movement.RIGHT])
		if Input.is_action_just_pressed("left"):
			change_menu(menu_vector_directions[Movement.LEFT])
		if Input.is_action_just_pressed("exit"):
			if current_menu == "order":
				menu_running = false
		if Input.is_action_just_pressed("interact"):
			if current_menu == "order":
				menu_running = false
				Order.emit(current_menu_topping_selected)
			if current_menu == "dough":
				EnteredDoughSize.emit()
			current_menu = ""
			return
	if Input.is_action_just_pressed("interact"):
		if await roll_dough():
			return
		if is_rolling_dough:
			return
		interact.emit(inventory)
		return

func animate():
	$AnimatedSprite2D.frame = facing_direction
	for label in $DoughRolling.get_children():
		label.visible = false
	if inventory.value is Dough:
		if not inventory.value.rollable: return
		$DoughRolling/ClickEToRoll.visible = true
	elif is_rolling_dough:
		$DoughRolling/CurrentlyRolling.visible = true
	
	# order menu
	if current_menu == "order":
		$OrderMenu.visible = true
		var selected_part = list_of_ingredients[current_menu_position.y][current_menu_position.x]
		for part in $OrderMenu/IngredientList.get_children():
			part.texture = part.normal
		selected_part.texture = selected_part.selected
		current_menu_topping_selected = selected_part.topping
	if current_menu == "dough":
		$DoughSizeSelection.visible = true
		var parts = $DoughSizeSelection/HBoxContainer.get_children()
		for part in parts:
			part.texture = part.normal
		var selected_part = parts[current_dough_pos]
		selected_part.texture = selected_part.selected
	if current_menu == "":
		$DoughSizeSelection.visible = false
		$OrderMenu.visible = false
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

var is_rolling_dough: bool

func roll_dough():
	if not inventory.value is Dough:
		return false
	if not inventory.value.rollable:
		return false
	var timer = get_tree().create_timer(time_it_takes_to_roll_dough)
	var subtracted = inventory.subtract()
	is_rolling_dough = true
	await timer.timeout
	inventory.add(Pizza.new(subtracted.size))
	is_rolling_dough = false
	return true

func prepare_menus():
	for topping in Global.list_of_ingredients: 
		var part = ingredient_menu_part.instantiate() as IngredientMenuPart
		part.normal = topping.normal
		part.selected = topping.selected
		part.topping = topping.new(false)
		$OrderMenu/IngredientList.add_child(part)
	var column: int = 0
	var row = []
	for menu_part in $OrderMenu/IngredientList.get_children():
		if column == $OrderMenu/IngredientList.columns:
			list_of_ingredients.append(row)
			row = []
			column = 0
		row.append(menu_part)
		column += 1
	if not row.is_empty():
		list_of_ingredients.append(row)
	$OrderMenu.visible = false
	$DoughSizeSelection.visible = false

var ingredient_menu_part = preload("res://scenes/ui/ingredient_menu_part.tscn")
var menu_running: bool = false
var current_menu_position: Vector2
var list_of_ingredients: Array
const menu_vector_directions = {
	Movement.DOWN: Vector2(0,1),
	Movement.UP: Vector2(0,-1),
	Movement.LEFT: Vector2(-1,0),
	Movement.RIGHT: Vector2(1,0)
}
var current_menu_topping_selected: Topping
signal Order
signal EnteredDoughSize
var current_dough_pos: int

func get_dough_size():
	$DoughSizeSelection.visible = true
	current_menu = "dough"
	menu_running = true
	await EnteredDoughSize
	menu_running = false
	return current_dough_pos

func order_ingredients(order_station):
	$OrderMenu.visible = true
	current_menu = "order"
	menu_running = true

func change_menu(d: Vector2):
	var direction = d
	if current_menu == "order":
		if current_menu_position.x + direction.x < 0 or \
		current_menu_position.x + direction.x > len(list_of_ingredients[current_menu_position.y]) - 1:
			direction = Vector2(0,0)
		if (current_menu_position.y + direction.y < 0 or current_menu_position.y + direction.y > 1):
			direction = Vector2(0,0)
		elif len(list_of_ingredients[current_menu_position.y + direction.y]) < current_menu_position.x + 1:
			direction = Vector2(0,0)
		current_menu_position += direction
	elif current_menu == "dough":
		if current_dough_pos + direction.x > 2 or current_dough_pos + direction.x < 0:
			direction = Vector2(0, 0)
		current_dough_pos += direction.x
