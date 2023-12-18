extends Node2D

signal change_scene
signal play_transition

func _init():
	Autoload.world = self
	
func _ready():
	$Pause.hide()
	
func _process(delta):
	$Pause.position = $Screen/Player.get_global_position()
	
	if Input.is_action_just_pressed("pause"):
		Autoload.pause_game($Pause)

func _on_door_area_body_entered(body):
	var next_path = 'res://scene/rooms/home/living_room.tscn'
	var current_scene = self
	
	change_scene.emit(next_path, current_scene)
