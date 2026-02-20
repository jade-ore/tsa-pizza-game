extends TextureRect
class_name IngredientMenuPart

@export var selected: Texture2D
@export var normal: Texture2D
@export var topping: Topping

func _ready() -> void:
	self.texture = normal

func select():
	$TextureRect.texture = selected

func deselect():
	$TextureRect.texture = normal
