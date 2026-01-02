extends Area2D
class_name DetectionComponent

var is_near: bool = false
@export var facing_me: bool = false

var relative_position: Vector2
var player: Node2D
var last_facing_direction: bool
var player_directions = {
	Vector2(-1, 0): 0,
	Vector2(1, 0): 1,
	Vector2(0, 1): 2,
	Vector2(0, -1): 3
} 

func _process(delta: float) -> void:
	if not is_near:
		facing_me = false
		return
	relative_position = player.position - global_position
	relative_position = round(relative_position.normalized())
	if not relative_position in player_directions:
		facing_me = last_facing_direction
	elif player_directions[relative_position] == player.get_direction():
		facing_me = true
	else:
		facing_me = false
	last_facing_direction = facing_me

func _on_body_entered(body: Node2D) -> void:
	is_near = true
	player = body

func _on_body_exited(body: Node2D) -> void:
	is_near = false
