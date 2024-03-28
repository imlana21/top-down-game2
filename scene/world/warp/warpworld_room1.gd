extends Node2D

var boss_killed: bool = false
var room2_door_opened: bool = false

func _ready():
	call_bos()

func call_bos():
	var boss_slime = load("res://scene/enemies/slime/slime.tscn").instantiate()
	boss_slime.type = "bos"
	boss_slime.global_position = Vector2(50, -50)
	$EnemyList.add_child(boss_slime)

func _on_room1_to_corridor1(body):
	# if boss_killed:
		$".."/Corridor1.door_handle()
		
func _on_room1_to_room2_player_entered(body):
	from_room2_door_handled()

func _on_from_room2_player_entered(body):
	from_room2_door_handled()

func from_room2_door_handled():
	for door in $DoorList.get_children():
		if !room2_door_opened:
			door.open_the_door()
		else:
			door.close_the_door()
	room2_door_opened = !room2_door_opened