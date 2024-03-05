extends CharacterBody2D

var is_near_crystal: bool = false

func _input(event):
	if Input.is_action_just_pressed("pick_item") and is_near_crystal:
		var next_path: String = ""
		var player_position: String = ""
		if Autoload.teleported_room.size() < 5:
			var room_index = randi_range(0, Autoload.teleport_room.size() - 1)
			next_path = "res://scene/world/cave/floor1/room/room_" + str(Autoload.teleport_room[room_index]) +".tscn"
			player_position = "CaveToRandomRoom" + str(Autoload.teleport_room[room_index])
			Autoload.teleported_room.append(Autoload.teleport_room[room_index])
			Autoload.teleport_room.remove_at(room_index)
		else:
			next_path = "res://scene/world/cave/floor1/cave_floor1.tscn"
			player_position = "OutFromRoom"
			Autoload.reset_teleport_room()
		Autoload.scene_manager._on_change_scene(next_path, Autoload.world, player_position)

func _on_area_detector_body_entered(body):
	is_near_crystal = true


func _on_area_detector_body_exited(body):
	is_near_crystal = false
