extends Control
const LABEL_ROTATION_TIME = 2
const LABEL_ROTATION_DEGREES = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate_label_around()

func rotate_label_around():
	var size_of_label = $Label.size
	$Label.pivot_offset = size_of_label / 2
	var tween = get_tree().create_tween()
	tween.tween_property($Label, "rotation_degrees", LABEL_ROTATION_DEGREES, LABEL_ROTATION_TIME)
	tween.tween_property($Label, "rotation_degrees", -1 * LABEL_ROTATION_DEGREES, LABEL_ROTATION_TIME)
	tween.set_loops()
	tween.bind_node(self)

func _on_level_selector_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_selector.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")

func _on_tutorial_pressed() -> void:
	var main_game = get_tree().change_scene_to_file("res://scenes/main_game.tscn")
	Global.level = -1
