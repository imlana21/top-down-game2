class_name WorldCave
extends Node2D

func set_pauce_layout():
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()

func get_random_cave_position():
	var random1 = Vector2(randi_range(376, 984), randi_range(400, 448))
	var random2 = Vector2(randi_range(384, 472), randi_range(264,328))
	var random3 = Vector2(randi_range(936, 984), randi_range(168, 440))
	var rand_pos = [random1, random2, random3]
	return rand_pos[randi_range(0, 2)]
