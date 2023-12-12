extends Node

@export var is_attacking: bool = false: set = set_is_attacking

func deg_mouse_position(body):
	var mouse_position = body.get_global_mouse_position()
	var angle_to_mouse = atan2(mouse_position.y - body.global_position.y, mouse_position.x - body.global_position.x)
	return rad_to_deg(angle_to_mouse)

func set_is_attacking(value):
	is_attacking = value

func angle_to_text(angle):
	match angle:
		-90.0, -45.0, -135.0:
			return "_up"
		0.0:
			return "_right"
		180.0:
			return "_left"
		45.0, 90.0, 135.0:
			return "_down"
