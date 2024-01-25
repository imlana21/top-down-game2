extends Node2D

var next_path = ""
var player_position = ""

signal change_scene
signal start_combat

func _ready():
	Autoload.world = self
	for pos in Autoload.ore_position:
		Autoload.spawn_ore(self, pos)
		
func _process(_delta):
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()

func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_upper_level_body_entered(body):
	next_path = "res://scene/world/cave/floor1/cave_floor1.tscn"
	player_position = "CaveToFloor1"
	_on_change_scene()	
