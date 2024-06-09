extends CharacterBody2D

var player_in_area: bool = false
var popup_state: bool = false

func _on_area_touch_body_entered(body) -> void:
	player_in_area = true

func _on_area_touch_body_exited(body) -> void:
	player_in_area = false


func _input(event) -> void:
	Autoload.prevent_inventory = player_in_area
	if Input.is_action_just_pressed('inventory') and Autoload.prevent_inventory:
		popup_state = !popup_state
		if popup_state:
			get_parent().find_child('ChestPopup').init_popup()
		else:
			get_parent().find_child('ChestPopup').reset_popup()

