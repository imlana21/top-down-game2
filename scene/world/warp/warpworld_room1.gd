extends Node2D

func _ready():
	call_bos()

func call_bos():
	var boss_slime = load("res://scene/enemies/slime/slime.tscn").instantiate()
	boss_slime.type = "bos"
	boss_slime.modulate = "3160ff"
	boss_slime.global_position = Vector2(1400, -50)
	$EnemyList.add_child(boss_slime)
