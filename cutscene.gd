extends Control
class_name Cutscene
@export var NextScene: PackedScene

enum {
	LEFT,
	RIGHT,
	END,
	CHANGE_POSITION_MIDDLE,
	CHANGE_POSITION_HOME
}
enum {
	NAME,
	TEXT
}
@export var Directions = {
	"Tutorial": RIGHT,
	"End": END,
	"ChangePositionMiddle": CHANGE_POSITION_MIDDLE,
	"ChangePositionHome": CHANGE_POSITION_HOME
}
@export var Sprites = {
	"Tutorial": null
}
@export var Dialogue = []
var CurrentChatbox: ChatBox
var current_index = -1

signal finished

func _ready() -> void:
	CurrentChatbox = null
	$PersonOnLeft/Button.pressed.connect(next_scene)
	$PersonOnRight/Button.pressed.connect(next_scene)

func set_dialogue(_dialogue: Array):
	Dialogue = _dialogue
	current_index = -1

func _show_dialogue():
	CurrentChatbox.visible = true
	CurrentChatbox.set_sprite(Sprites[Dialogue[current_index][NAME]])
	CurrentChatbox.change_name(Dialogue[current_index][NAME])
	CurrentChatbox.set_dialogue(Dialogue[current_index][TEXT])

func next_scene():
	visible = true
	if CurrentChatbox:
		CurrentChatbox.visible = false
	current_index += 1
	var dir = Directions[Dialogue[current_index][NAME]]
	match dir:
		LEFT:
			CurrentChatbox = $PersonOnLeft
			_show_dialogue()
		RIGHT:
			CurrentChatbox = $PersonOnRight
			_show_dialogue()
		END:
			finished.emit()
			if NextScene:
				get_tree().change_scene_to_packed(NextScene)
			else:
				visible = false
		CHANGE_POSITION_MIDDLE:
			position.y = -300
			next_scene()
		CHANGE_POSITION_HOME:
			position.y = 0
			next_scene()
