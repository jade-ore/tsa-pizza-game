extends Node2D

var customer_at_cashier: Node2D = null
var order: Pizza

# Randomize customer arrival
# Have customer choose which of the three stations
# Start a timer, divide timer into 5 sections, stars go down after cutoff until order taken
# Take order, have it show up at bottom of screen
# Start a timer, divide timer into 5 sections, stars go down after cutoff pizza given
# Customer leaves

func run(inventory):
	if not customer_at_cashier:
		return
	customer_at_cashier.interact()
	
