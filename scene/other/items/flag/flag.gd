extends CharacterBody2D

func _ready():
	var flag_zone = preload("res://scene/other/items/flag/flag_area.tscn").instantiate()
	flag_zone.name = "FlagArea_" + str(floor(position.x)) + "_" + str(floor(position.y))
	flag_zone.scale = Vector2(0.8, 0.8)
	flag_zone.global_position = get_global_position()
	Autoload.world.add_child(flag_zone)
