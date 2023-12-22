extends Node2D

signal change_scene

var next_path = ""

func _process(delta):
	Autoload.pause_scale = Vector2(0.3, 0.3)
	Autoload.pause_position = Autoload.player.get_global_position()
	
func _on_change_scene():
	change_scene.emit(next_path, self)

func _on_to_living_room_door_area_body_entered(body):
	next_path = "res://scene/rooms/home/living_room.tscn"
	_on_change_scene()
