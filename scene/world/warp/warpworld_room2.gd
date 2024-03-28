extends Node2D

var enemies_pos: Array

func _ready():
	for slime in $EnemyList.get_children():
		slime.visible = false
		enemies_pos.append(slime.position)		

func call_slimes():
	await get_tree().create_timer(1).timeout
	for slime in $EnemyList.get_children():
		$EnemyList.remove_child(slime)	
	await get_tree().create_timer(2).timeout
	for pos in enemies_pos:
		Autoload.spawn_enemy($EnemyList, pos, "normal")
	for slime in $EnemyList.get_children():
		slime.visible = false

func _on_to_corridor_2_body_entered(body):
	$".."/Corridor2.door_handle()
