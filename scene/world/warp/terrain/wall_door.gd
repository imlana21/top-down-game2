extends CharacterBody2D

func open_the_door():
	await get_tree().create_timer(1).timeout
	visible = false
	set_collision_layer_value(1, false)

func close_the_door():
	await get_tree().create_timer(1).timeout
	visible = true
	set_collision_layer_value(1, true)
