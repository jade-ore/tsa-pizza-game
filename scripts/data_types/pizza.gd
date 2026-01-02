extends Resource
class_name Pizza

enum cooked_state {RAW, COOKED, BURNT}

@export var dough = Dough.new()
@export var toppings: Array
@export var cooked: int

static func generate_pizza():
	var TOPPINGS_LIST = {
	Cheese: 100,
	Sauce: 100,
	Mushrooms: 30,
	Onions: 5,
	Olives: 10,
	Pepperoni: 60,
	Sausage: 40
	}
	var topping_array = []
	for topping in TOPPINGS_LIST:
		if randf() * 100 <= TOPPINGS_LIST[topping]: topping_array.append(topping.new(true))
	return Pizza.new(topping_array)

func _init(input_toppings: Array = []):
	dough.rolled = true
	toppings = input_toppings

func add_topping(topping: Topping):
	toppings.append(topping)

func _to_string() -> String:
	var return_string: String = "Pizza, cooked: " + str(cooked) + "toppings: " 
	for item in toppings:
		@warning_ignore("unassigned_variable_op_assign")
		return_string += str(item) + " "
	return return_string

func get_toppings():
	return toppings

func cook():
	if cooked == cooked_state.COOKED or cooked == cooked_state.BURNT:
		print("BURNT HAHA")
		cooked = cooked_state.BURNT
		return
	cooked = cooked_state.COOKED

func is_equal(other: Pizza):
	var self_ingredient_dict: Dictionary
	var incorrect_toppings: Array = []
	var pizza_correct: bool = false
	for topping in toppings:
		self_ingredient_dict[str(topping)] = true
	for topping in other.toppings:
		if not self_ingredient_dict[str(topping)]:
			incorrect_toppings.append(topping)
	if len(incorrect_toppings) == 0:
		pizza_correct = true
	return [pizza_correct, incorrect_toppings]
