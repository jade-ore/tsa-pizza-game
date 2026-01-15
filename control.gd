extends TextureRect
class_name IngredientMenuPart

@export var selected: CompressedTexture2D
@export var normal: CompressedTexture2D
@export var topping: Topping

func _ready() -> void:
	self.texture = normal

func select():
	$TextureRect.texture = selected

func deselect():
	$TextureRect.texture = normal
