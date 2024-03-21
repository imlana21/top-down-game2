extends Node2D

func _ready():
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()
	_init_enemy()
	_open_the_door()

func _close_the_door():
	$Door.visible = true
	$Door.tile_set.set_physics_layer_collision_layer(0, 1)

func _open_the_door():
	$Door.visible = false
	$Door.tile_set.set_physics_layer_collision_layer(0, 0)

func _init_enemy():
	if !Autoload.warpworld_enemy_killed:
		var enemy_scene = load("res://scene/enemies/slime/slime.tscn").instantiate()
		# enemy_scene.scale = Vector2(3, 3)
		enemy_scene.global_position = Vector2(-200, -30)
		enemy_scene.type = "bos"
		$EnemyList.add_child(enemy_scene)	

func _on_door_area_body_exited(body):
	pass

func _on_door_area_body_entered(body):
	if !Autoload.warpworld_enemy_killed:
		_close_the_door()
	else:
		_open_the_door()
