extends Node2D

@export var max_parts_spawn = 10
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

func _ready():
	$Spawner.start()
	Autoload.world = self

func _on_spawner_timeout():
	if index_spawn > max_parts_spawn:
		$Spawner.stop()
		return
	var randi_index = randi_range(0, parts_list.size() - 1)
	var randi_list = [
		Vector2(randi_range(-688, -32), randi_range(-448, -32)),
		Vector2(randi_range(16, 720), randi_range(-432, -32)),
		Vector2(randi_range(16, 720), randi_range(16, 416)),
		Vector2(randi_range(-752, -32), randi_range(16, 400))
	]
	var randi_pos = randi_list[randi_range(0, 3)]
	var item = load("res://scene/other/items/" + parts_list[randi_index] + "/" + parts_list[randi_index] +".tscn").instantiate()
	item.global_position = randi_pos
	print("Items " + parts_list[randi_index] + " spawned on " + str(randi_pos))
	add_child(item)
	index_spawn += 1 
	$Spawner.start()