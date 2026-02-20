extends Control
class_name Cutscene
@export var NextScene: PackedScene
enum {
	LEFT,
	RIGHT,
	END
}
enum {
	NAME,
	TEXT
}
@export var Directions = {
	"Jayden": LEFT,
	"Jayden's swarm enemy": RIGHT,
	"End": END,
	"stuthi": LEFT,
	"owen": RIGHT
}
@export var Sprites = {
	"Jayden": preload("res://assets/img/sprites/girl_chef_still_2.png"),
	"Jayden's swarm enemy": preload("res://assets/img/sprites/girl_chef_still_2.png"),
}
@export var Dialogue = [
	["Jayden", "Please give me money"],
	["Jayden's swarm enemy", "I hate you"],
	["stuthi", "I LOVE MUSHROOMS"],
	["owen", "i hate mushrooms. i love cheese"],
	["stuthi", "MUSHROOMS ARE BETTER"],
	["owen", "Wrong. Cheese is better"],
	["stuthi", "Mushrooms are 6.7 inches tall"],
	["stuthi", "I also said the 6th and 7th message"],
	["owen", "SIX SEVENENNENENENENENNENENENENENENN"]
]
var CurrentChatbox: ChatBox
var current_index = 0

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	CurrentChatbox = $PersonOnLeft
	$PersonOnLeft/Button.pressed.connect(next_scene)
	$PersonOnRight/Button.pressed.connect(next_scene)

func set_dialogue(_dialogue: Array):
	Dialogue = _dialogue

func show_dialogue():
	CurrentChatbox.visible = true
	CurrentChatbox.set_sprite(Sprites[Dialogue[current_index][NAME]])
	CurrentChatbox.change_name(Dialogue[current_index][NAME])
	CurrentChatbox.set_dialogue(Dialogue[current_index][TEXT])

func next_scene():
	CurrentChatbox.visible = false
	current_index += 1
	var dir = Directions[Dialogue[current_index][NAME]]
	CurrentChatbox = null
	match dir:
		LEFT:
			CurrentChatbox = $PersonOnLeft
			show_dialogue()
		RIGHT:
			CurrentChatbox = $PersonOnRight
			show_dialogue()
		END:
			if NextScene:
				get_tree().change_scene_to_packed(NextScene)
			else:
				visible = false
