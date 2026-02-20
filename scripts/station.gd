extends Node2D 

@export var detection_area1: DetectionComponent
@export var detection_area2: DetectionComponent
@export var interact_component: InteractComponent

@export var sprite: SpriteFrames

@export var extra_station_info = null

enum {
	NORMAL,
	FACED,
	SELECTED
}
var dir: int

var selected_check: bool
var player1_facing: bool
var player2_facing: bool

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = sprite

func animate():
	$AnimatedSprite2D.frame = dir

func _process(delta: float) -> void:
	player1_facing = detection_area1.facing_me
	if player1_facing:
		Global.selected_station1 = self
		if selected_check:
			return
		dir = FACED
		animate()
		return
	if Global.selected_station1 == self:
		Global.selected_station1 = null
	player2_facing = detection_area2.facing_me
	if player2_facing:
		Global.selected_station2 = self
		if selected_check:
			return
		dir = FACED
		animate()
		return
	if Global.selected_station2 == self:
		Global.selected_station2 = null
	dir = NORMAL
	animate()

func interact(inventory):
	selected_check = true
	dir = SELECTED
	animate()
	$TextureTimer.start()
	interact_component.run(inventory)

func _on_texture_timer_timeout() -> void:
	selected_check = false
