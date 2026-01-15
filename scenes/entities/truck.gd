extends Sprite2D

@export var ingredient: Topping

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(1072.0, 600), 1)
