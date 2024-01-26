class_name WorldCaveFloor2
extends WorldCave

var rare_spawn_chance: float = 0.75

var next_path = ""
var player_position = ""

signal change_scene
signal start_combat

func _ready():
	Autoload.world = self
	Autoload.ore_name_2 = []
	Autoload.rare_ore_name = []
	init_rare_ore_position()
	for pos in Autoload.ore_position_2:
		Autoload.spawn_ore(self, pos, 2)
	for pos in Autoload.rare_ore_position:
		Autoload.spawn_rare_ore(self, pos)
		
func _process(_delta):
	set_pauce_layout()

func _on_change_scene():
	change_scene.emit(next_path, self, player_position)

func _on_upper_level_body_entered(body):
	next_path = "res://scene/world/cave/floor1/cave_floor1.tscn"
	player_position = "CaveToFloor1"
	_on_change_scene()	

func get_random_cave_position():
	var random1 = Vector2(randi_range(456, 760), randi_range(-24, 8))
	var random2 = Vector2(randi_range(380, 448), randi_range(-24, 176))
	var random3 = Vector2(randi_range(320, 595), randi_range(184, 408))
	var rand_pos = [random1, random2, random3]
	return rand_pos[randi_range(0, 1)]

func init_rare_ore_position():
	var random_pos = Vector2.ZERO
	Autoload.rare_ore_position = []
	for i in range(0, 1):
		if CombatDetail.spawn_chance(rare_spawn_chance):
			random_pos = get_random_cave_position()
			print("Rare Position in floor 2 On ", random_pos)
			Autoload.rare_ore_position.append(random_pos)
