extends Node2D

signal change_scene
signal play_transition
signal start_combat

func _init():
	Autoload.world = self
	
func _process(delta):
	Autoload.pause_scale = Vector2(0.3, 0.3)
	Autoload.pause_position = Autoload.player.get_global_position()

func _on_door_area_body_entered(body):
	var next_path = 'res://scene/rooms/home/living_room.tscn'
	var current_scene = self
	
	change_scene.emit(next_path, current_scene)

func _on_player_start_combat():
	start_combat.emit(self)
