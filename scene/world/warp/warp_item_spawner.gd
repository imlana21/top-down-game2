extends Timer

@export var max_item_spawn = 50
@export var spawn_delay = 0.8
@onready var spawn_area = $"../MeshInstance"
var item_spawned = 0

func _ready():
	wait_time = spawn_delay
		
func _on_timeout():
	if item_spawned < max_item_spawn:
		var random_pos = spawn_area.position + Vector2(randf_range((-spawn_area.scale.x/2), (spawn_area.scale.x/2)), 
								randf_range((-spawn_area.scale.y/2), (spawn_area.scale.y/2)))
		print("Item ", item_spawned + 1, " spawned on ", random_pos)
		_spawn_floor(random_pos)
		item_spawned += 1
		start()
		
func _spawn_floor(pos):
	var floor_scene = load("res://scene/other/other/light_square.tscn").instantiate()
	floor_scene.global_position = pos
	floor_scene.name = "LightFloor_" + str(floor(pos.x)) + "_" + str(floor(pos.y))
	floor_scene.is_gold = (randf_range(0, 1) <= 0.1)
	get_parent().add_child(floor_scene)
