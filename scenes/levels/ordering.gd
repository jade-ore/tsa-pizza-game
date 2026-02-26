extends Control
class_name MenuOrdering

func order(item):
	$BG/Order.text = "Currently Ordering: " + str(item)

func reset():
	$BG/Order.text = "Currently Ordering: Nothing!!!" 
