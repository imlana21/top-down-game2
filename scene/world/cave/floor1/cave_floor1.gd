class_name WorldCaveFloor1
extends WorldCave

signal change_scene
signal start_combat

var next_path = ""
var player_position = ""

func _ready():
	Autoload.world = self
	Autoload.ore_name_1 = []
	for pos in Autoload.ore_position_1:
		Autoload.spawn_ore(self, pos, 1)
		
func _process(_delta):
	set_pauce_layout()

func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_outside_cave_body_entered(body):
	next_path = "res://scene/world/world.tscn"
	player_position = "CaveToWorld"
	_on_change_scene()	

func _on_depper_level_body_entered(body):
	next_path = "res://scene/world/cave/floor2/cave_floor2.tscn"
	player_position = "CaveToFloor2"
	_on_change_scene()

func get_random_cave_position():
	var random1 = Vector2(randi_range(376, 984), randi_range(400, 448))
	var random2 = Vector2(randi_range(384, 472), randi_range(264,328))
	var random3 = Vector2(randi_range(936, 984), randi_range(168, 440))
	var rand_pos = [random1, random2, random3]
	
	return rand_pos[randi_range(0, 2)]
