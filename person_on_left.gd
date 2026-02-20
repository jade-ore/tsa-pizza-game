extends Control
class_name ChatBox
@export var NameBox: BoxWithText
@export var TextBox: BoxWithText
@export var SpriteRect: TextureRect

func change_name(_text: String):
	NameBox.label.text = _text

func set_dialogue(_text: String):
	TextBox.label.text = _text

func set_sprite(texture):
	$TextureRect.texture = texture
