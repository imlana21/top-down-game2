extends Node2D

signal change_scene

var next_path = ""

func _on_change_scene():
	change_scene.emit(next_path, self)

func _on_to_living_room_door_area_body_entered(body):
	next_path = "res://scene/rooms/home/living_room.tscn"
	_on_change_scene()
