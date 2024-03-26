extends Node2D

var boss_killed: bool = false

func _ready():
	call_bos()

func call_bos():
	var boss_slime = load("res://scene/enemies/slime/slime.tscn").instantiate()
	boss_slime.type = "bos"
	boss_slime.global_position = Vector2(50, -50)
	$EnemyList.add_child(boss_slime)

func _on_room1_to_corridor1(body):
	# if boss_killed:
		for door in $".."/Corridor1/DoorList.get_children():
			door.close_the_door()

func _on_room1_to_room2_player_entered(body):
	for door in $DoorList.get_children():
		door.open_the_door()

func _on_to_room1_player_entered(body):
	for door in $DoorList.get_children():
		door.close_the_door()
