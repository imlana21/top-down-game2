extends CharacterBody2D

var mouse_in_area: bool = false

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_in_area:
			Autoload.machine_inventory = self

func _on_area_2d_mouse_entered():
	mouse_in_area = true

func _on_area_2d_mouse_exited():
	mouse_in_area = false
