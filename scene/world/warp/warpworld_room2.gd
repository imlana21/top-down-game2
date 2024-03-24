extends Node2D

var slime_position: Array

func _ready():
	for slime in $EnemyList.get_children():
		slime_position.append(slime.get_global_position())

func _on_door_player_body_entered(body):
	await get_tree().create_timer(1).timeout
	$Door/Door1.set_collision_layer_value(1,false)
	$Door/Door2.set_collision_layer_value(1,false)
	$Door/Door1.visible = false
	$Door/Door2.visible = false
	for slime in $EnemyList.get_children():
		$EnemyList.remove_child(slime)
	call_slimes()

func call_slimes():
	for pos in slime_position:
		Autoload.spawn_enemy(self, pos, "normal")
