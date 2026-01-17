extends Player

func _physics_process(delta: float) -> void:
	movement_direction = Input.get_vector('left1', 'right1', 'up1', 'down1')
	if not menu_running:
		velocity = movement_direction * speed
		find_facing_direction()
	animate()
	move_and_slide()
	last_direction = round(movement_direction)

func _input(_event: InputEvent) -> void:
	if menu_running:
		if Input.is_action_just_pressed("down1"):
			change_menu(menu_vector_directions[Movement.DOWN])
		if Input.is_action_just_pressed("up1"):
			change_menu(menu_vector_directions[Movement.UP])
		if Input.is_action_just_pressed("right1"):
			change_menu(menu_vector_directions[Movement.RIGHT])
		if Input.is_action_just_pressed("left1"):
			change_menu(menu_vector_directions[Movement.LEFT])
		if Input.is_action_just_pressed("exit1"):
			menu_running = false
		if Input.is_action_just_pressed("interact1"):
			menu_running = false
			Order.emit(current_menu_topping_selected)
			return
	if Input.is_action_just_pressed("interact1"):
		if await roll_dough():
			return
		interact.emit(inventory)
		return

func animate():
	$"../CanvasLayer/Label".text = "Player 1 items: " + str(inventory)
	$AnimatedSprite2D.frame = facing_direction
	$OrderMenu.visible = menu_running
	for label in $DoughRolling.get_children():
		label.visible = false
	if inventory.value is Dough and inventory.value.rollable:
		$DoughRolling/ClickEToRoll.visible = true
	elif is_rolling_dough:
		$DoughRolling/CurrentlyRolling.visible = true
	
	# order menu
	var selected_part = list_of_ingredients[current_menu_position.y][current_menu_position.x]
	for part in $OrderMenu/IngredientList.get_children():
		part.texture = part.normal
	selected_part.texture = selected_part.selected
	current_menu_topping_selected = selected_part.topping

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
	if not inventory.value.rollable:
		return false
	var timer = get_tree().create_timer(time_it_takes_to_roll_dough)
	var subtracted = inventory.subtract()
	is_rolling_dough = true
	await timer.timeout
	inventory.add(Pizza.new())
	is_rolling_dough = false
	return true

func set_ingredient_menu():
	for topping in Global.list_of_ingredients: 
		var part = ingredient_menu_part.instantiate() as IngredientMenuPart
		part.normal = topping.normal
		part.selected = topping.selected
		part.topping = topping.new(false)
		if part.topping is Dough:
			print(part.topping.rollable)
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

func order_ingredients(order_station):
	$OrderMenu.visible = true
	menu_running = true

func change_menu(d: Vector2):
	var direction = d
	if current_menu_position.x + direction.x < 0 or \
	current_menu_position.x + direction.x > len(list_of_ingredients[current_menu_position.y]) - 1:
		direction = Vector2(0,0)
	if (current_menu_position.y + direction.y < 0 or current_menu_position.y + direction.y > 1):
		direction = Vector2(0,0)
	elif len(list_of_ingredients[current_menu_position.y + direction.y]) < current_menu_position.x + 1:
		direction = Vector2(0,0)
	current_menu_position += direction
