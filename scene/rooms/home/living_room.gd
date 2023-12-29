extends Node2D

signal change_scene
#signal player_position 
signal start_combat

var next_path = ""
var player_position = ""

func _process(_delta):
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()
	print(Autoload.player.position)
	
func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_to_kitchen_door_area_body_entered(body):
	if body.is_in_group("player"):
		next_path = 'res://scene/rooms/home/kitchen.tscn'
		player_position = "LivingRoomToKitchen"
		_on_change_scene()

func _on_to_out_door_area_body_entered(body):
	if body.is_in_group("player"):
		next_path = 'res://scene/rooms/world.tscn'
		player_position = "LivingRoomToWorld"
		_on_change_scene()
