extends Node2D

signal change_scene
signal start_combat

var next_path = ""
var player_position = ""

func _process(_delta):
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()

func _on_to_living_room_door_area_body_entered(_body):
	next_path = "res://scene/rooms/home/living_room/living_room.tscn"
	player_position = "KitchenToLivingRoom"
	
	_on_change_scene()	
	
func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

