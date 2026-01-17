extends Sprite2D

@export var ingredient: Topping

var package_scene = preload("res://scenes/other/package.tscn")

func _ready() -> void:
	global_position = Vector2(1280.0, 600)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(1072.0, 600), 1)
	await tween.finished
	tween.stop()
	var package = package_scene.instantiate()
	package.topping = ingredient
	package.global_position = global_position + Vector2(-50, 0)
	get_parent().add_child(package)
	tween.tween_property(self, "global_position", Vector2(1280.0, 600), 1)
	tween.play()
	await tween.finished
	queue_free()
