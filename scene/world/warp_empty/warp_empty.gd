extends Node2D

var coord_lists: Array = [
	Vector2(-328, -168),
	Vector2(-44, -150),
	Vector2(80, -80),
	Vector2(320, 104),
	Vector2(-320, 164),
	Vector2(20, 100)
];
var parts_list: Array = [
	'cables', 
	'capacitor',
	'cpu',
	'diode',
	'gear',
	'ic'
]
var index_spawn: int = 0
signal change_scene
signal start_combat

func _on_spawner_timeout():
	if index_spawn >=  coord_lists.size():
		index_spawn = 0
		$Spawner.stop()
		return
	var item = load("res://scene/other/items/" + parts_list[index_spawn] + "/" + parts_list[index_spawn] +".tscn").instantiate()
	item.global_position = coord_lists[index_spawn]
	print("Items " + parts_list[index_spawn] + " spawned on " + str(coord_lists[index_spawn]))
	add_child(item)
	index_spawn += 1