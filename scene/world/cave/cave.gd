extends Node2D

signal change_scene
signal start_combat

var next_path = ""
var player_position = ""

func _process(_delta):
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()

func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_outside_cave_body_entered(body):
	next_path = "res://scene/world/world.tscn"
	player_position = "CaveToWorld"
	
	_on_change_scene()	
