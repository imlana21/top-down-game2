class_name WorldCave
extends Node2D

signal change_scene
signal start_combat

var next_path = ""
var player_position = ""

func _ready():
	Autoload.world = self
	
	for pos in Autoload.ore_position:
		Autoload.spawn_ore(self, pos)
		
func _process(_delta):
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()
	get_random_cave_position()

func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_outside_cave_body_entered(body):
	next_path = "res://scene/world/world.tscn"
	player_position = "CaveToWorld"
	_on_change_scene()	

func get_random_cave_position():
	var random1 = Vector2(randi_range(376, 984), randi_range(400, 448))
	var random2 = Vector2(randi_range(384, 472), randi_range(264,328))
	var random3 = Vector2(randi_range(936, 984), randi_range(168, 440))
	var rand_pos = [random1, random2, random3]
	
	return rand_pos[randi_range(0, 2)]
