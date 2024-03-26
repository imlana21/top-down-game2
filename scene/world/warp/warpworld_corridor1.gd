extends Node2D

var enemies_pos: Array
var door_reacher = false

func _ready():
	for slime in $EnemyList.get_children():
		slime.visible = false
		enemies_pos.append(slime.position)

func _on_door_sensor_body_entered(body):
	for door in $DoorList.get_children():
		door.open_the_door()
	call_slimes()

func call_slimes():
	await get_tree().create_timer(1).timeout
	for slime in $EnemyList.get_children():
		$EnemyList.remove_child(slime)	
	await get_tree().create_timer(2).timeout
	for pos in enemies_pos:
		Autoload.spawn_enemy($EnemyList, pos, "normal")
