extends Node2D

var enemies_pos: Array
var door_opened = false

func _ready():
	for slime in $EnemyList.get_children():
		slime.visible = false
		enemies_pos.append(slime.position)

func _on_to_room_3_body_entered(body):
	if !door_opened:
		call_slimes()
	door_handle()
	
func call_slimes():
	await get_tree().create_timer(1).timeout
	for slime in $EnemyList.get_children():
		$EnemyList.remove_child(slime)	
	await get_tree().create_timer(2).timeout
	for pos in enemies_pos:
		Autoload.spawn_enemy($EnemyList, pos, "normal")
	for slime in $EnemyList.get_children():
		slime.visible = false

func door_handle():
	for door in $DoorList.get_children():
		if !door_opened:
			door.open_the_door()
		else:
			door.close_the_door()
	door_opened = !door_opened