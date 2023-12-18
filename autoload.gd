extends Node

var is_attacking: bool = false: set = set_is_attacking
var is_paused: bool = false
var player: CharacterBody2D
var world: Node2D

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused

func pause_game(body):
	toggle_pause()
	if Autoload.is_paused:
		body.show()
	else:
		body.hide()

func set_is_attacking(value):
	is_attacking = value

func deg_mouse_position(body):
	var mouse_position = body.get_global_mouse_position()
	var angle_to_mouse = atan2(mouse_position.y - body.global_position.y, mouse_position.x - body.global_position.x)
	return rad_to_deg(angle_to_mouse)

func angle_to_text(angle):
	match angle:
		-90.0, -45.0, -135.0:
			return "up"
		0.0:
			return "right"
		180.0:
			return "left"
		45.0, 90.0, 135.0:
			return "down"
