extends Node2D 

@export var detection_area: DetectionComponent
@export var interact_component: InteractComponent

@export var selected = load("res://assets/img/objects/station_selected.png")
@export var faced = load("res://assets/img/objects/station_faced.png")
@export var normal = load("res://assets/img/objects/station.png")

var selected_check: bool
var player_facing: bool

func _process(delta: float) -> void:
	player_facing = detection_area.facing_me
	if player_facing:
		Global.selected_station = self
		if selected_check:
			return
		$Sprite2D.set_texture(faced)
		return
	if Global.selected_station == self:
		Global.selected_station = null
	$Sprite2D.set_texture(normal)

func interact(inventory):
	selected_check = true
	$Sprite2D.set_texture(selected)
	$TextureTimer.start()
	interact_component.run(inventory)

func _on_texture_timer_timeout() -> void:
	selected_check = false
