extends Resource
class_name Pizza

enum cooked_state {RAW, COOKED, BURNT}
var cooked_state_names = ["RAW", "COOKED", "BURNT"]

@export var dough = Dough.new(true)
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
	return Pizza.new(topping_array, 1)

func _init(input_toppings: Array = [], how_cooked = cooked_state.RAW):
	toppings = input_toppings
	cooked = how_cooked

func add_topping(topping: Topping):
	toppings.append(topping)

func _to_string() -> String:
	var return_string: String = "Pizza, cooked: " + cooked_state_names[cooked] + " toppings: " 
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

func compare_to(other: Pizza):
	if other is not Pizza: return -999
	var self_ingredient_dict: Dictionary
	var incorrect_toppings: Array = []
	for topping in toppings:
		self_ingredient_dict[str(topping)] = true
	for topping in other.toppings:
		if not str(topping) in self_ingredient_dict:
			incorrect_toppings.append(topping)
	var num_of_toppings: float = len(toppings)
	var percentage = 1 - (len(incorrect_toppings) / num_of_toppings)
	if cooked != other.cooked: percentage -= 0.5
	var stars = remap(percentage, 0, 1, 0, 5)
	return floor(stars)
