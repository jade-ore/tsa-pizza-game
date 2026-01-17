extends Sprite2D

@export var faced = load("res://assets/img/objects/package/package_faced.png")
@export var normal = load("res://assets/img/objects/package/package_normal.png")
@export var selected = load("res://assets/img/objects/package/package_selected.png")

@export var topping: Topping

@export var inventory: ToppingStationInventoryComponent
@export var detection_component: DetectionComponent

var selected_check: bool

func _ready() -> void:
	inventory.value = topping
	inventory.amount = 5

func _process(delta: float) -> void:
	var is_near = detection_component.is_near
	if is_near:
		Global.selected_station = self
		if selected_check:
			return
		self.set_texture(faced)
		return
	if Global.selected_station == self:
		Global.selected_station = null
	self.set_texture(normal)

func interact(plr_inventory: InventoryComponent):
	selected_check = true
	self.set_texture(selected)
	$TextureTimer.start()
	var item_subtracted = inventory.subtract()
	if not plr_inventory.value:
		plr_inventory.add(item_subtracted)
	if inventory.amount == 0:
		queue_free()
		get_parent().order_currently_here = false
	

func _on_texture_timer_timeout() -> void:
	selected_check = false
