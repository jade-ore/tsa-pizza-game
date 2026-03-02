extends AnimatedSprite2D
class_name Package

enum {normal, faced, selected}

@export var topping: Topping

@export var inventory: ToppingStationInventoryComponent
@export var detection_component: DetectionComponent
@export var detection_component2: DetectionComponent

var selected_check: bool

func _ready() -> void:
	inventory.value = topping
	inventory.amount = 5

func _process(delta: float) -> void:
	var is_near = detection_component.is_near
	if is_near:
		Global.selected_station1 = self
		if selected_check:
			return
		frame = faced
		return
	if Global.selected_station1 == self:
		Global.selected_station1 = null
	frame = normal
	var is_near2 = detection_component2.is_near
	if is_near2:
		Global.selected_station2 = self
		if selected_check:
			return
		frame = faced
		return
	if Global.selected_station2 == self:
		Global.selected_station2 = null
	frame = normal

func interact(plr_inventory: InventoryComponent):
	selected_check = true
	frame = selected
	$TextureTimer.start()
	var item_subtracted = inventory.subtract()
	if not plr_inventory.value:
		plr_inventory.add(item_subtracted)
	if inventory.amount == 0:
		queue_free()
		get_parent().order_currently_here = false
	

func _on_texture_timer_timeout() -> void:
	selected_check = false
