extends ColorRect

@export var order_label: Label

func set_order(order):
	order_label.text = order.parse_order()
	visible = true

func remove_order():
	visible = false
	order_label.text = ""
