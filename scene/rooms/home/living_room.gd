extends Node2D

signal change_scene
signal player_position 

var next_path = ""

func _on_change_scene():
	change_scene.emit(next_path, self)
		
func _on_to_kitchen_door_area_body_entered(body):
	if body.is_in_group("player"):
		next_path = 'res://scene/rooms/home/kitchen.tscn'
		_on_change_scene()

func _on_to_out_door_area_body_entered(body):
	if body.is_in_group("player"):
		next_path = 'res://scene/rooms/world.tscn'
		_on_change_scene()
