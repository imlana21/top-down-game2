extends Node2D

var next_scene = null
var current_scene = null
var player_point = null
var vector_position = null

@export var MAX_ENEMY = 5

@onready var anim_trans = $ScreenTransition/AnimationTransition
@onready var combat_scene = preload("res://scene/combat/battle_combat.tscn")
@onready var countdown_spawn = preload("res://scene/enemies/countdown_spawner.tscn")

func _ready():
	Autoload.scene_manager = self
	$PauseLayer/Pause.hide()
	$ChangeSkinLayer/SkinMenu.hide()
	await load_game()
	Autoload.world.connect("change_scene", _on_change_scene)
	Autoload.world.connect("start_combat", _on_player_start_combat)
	
func _on_timeout_spawn_enemy(pos):
	var random_pos = Autoload.random_position()
	print("Enemy spawn in position ", random_pos)
	Autoload.enemy_position.append(random_pos)
	Autoload.spawn_enemy(Autoload.world, random_pos)

func _on_timeout_spawn_ore_on_floor_1(pos):
	var world_cave = WorldCaveFloor1.new()
	world_cave = world_cave.get_random_cave_position()
	print("Ore spawn in position ", world_cave)
	Autoload.spawn_ore(Autoload.world, world_cave, 1)
	Autoload.ore_position_1.append(world_cave)

func _on_timeout_spawn_ore_on_floor_2(pos):
	var world_cave = WorldCaveFloor2.new()
	world_cave = world_cave.get_random_cave_position()
	print("Ore spawn in position ", world_cave)
	Autoload.ore_position_2.append(world_cave)
	Autoload.spawn_ore(Autoload.world, world_cave, 2)
	_on_timeout_spawn_rare_ore_on_floor_2(pos)

func _on_timeout_spawn_rare_ore_on_floor_2(pos):
	var world_cave = WorldCaveFloor2.new()
	world_cave = world_cave.get_random_cave_position()
	if CombatDetail.spawn_chance(0.75):
		print("Rare Ore spawn in position ", world_cave)
		Autoload.spawn_rare_ore(Autoload.world, world_cave)
		Autoload.rare_ore_position.append(world_cave)	
	
func _on_timeout_spawn_tree(pos):
	var random_pos = Autoload.random_position()
	if Autoload.world.name == 'World':
		print("Tree spawn in position ", pos)
		Autoload.spawn_tree(Autoload.world, random_pos)
	else:
		Autoload.tree_position.append(pos)
	
func _on_change_scene(next_path: String, current: Node2D, player_pos = null, vector_pos = null):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	next_scene.connect("start_combat", _on_player_start_combat)
	current_scene = current
	player_point = player_pos
	vector_position = vector_pos
	anim_trans.play("fade_in")

func _on_player_start_combat(current_world):	
	print("StartCombat")
	current_scene = current_world
	next_scene = combat_scene.instantiate()
	next_scene.next_world_name = current_world.name
	next_scene.connect("change_combat", _on_player_finish_combat)
	anim_trans.play("fade_in")

func _on_player_finish_combat(next_path, current_world):
	current_scene = current_world
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	next_scene.connect("start_combat", _on_player_start_combat)
	anim_trans.play("fade_in")
	
func _on_animation_transition_finished(anim_name):	
	match anim_name:
		"fade_in":
			start_fade_in()
		"fade_out":
			start_fade_out()

func _on_loader_start_combat():
	$CurrentScene.add_child(next_scene)
	current_scene = next_scene
	next_scene = null
	
func start_fade_in():
	current_scene.queue_free()
	anim_trans.play("fade_out")

func start_fade_out():
	_on_loader_start_combat()
	if player_point != null:
		Autoload.player.position = Autoload.enter_world_position[player_point]
		player_point = null
	if vector_position != null:
		Autoload.player.global_position = vector_position
		vector_position = null
	
func load_game():
	if Autoload.is_load_game:
		var save_load = SaveManager.new()
		save_load.load_world(Autoload.load_data)
		Autoload.is_load_game = false
		Autoload.load_data = null
	else:
		new_game()

func new_game():
	var inv = InventoryItems.new()
	var next_path = 'res://scene/world/world.tscn'
	var curr_world = $CurrentScene.get_children()[0]
	_on_change_scene(next_path, curr_world)
	Autoload.player.CHAR_DETAIL = {
		"atk_speed": 0.6,
		"max_hp": 50,
		"curr_hp": 50,
		"luk": 0.5,
		"def": 1,
		"str": 3,
		"exp": 0,
		"level": 1
	}
	inv.save_items([])
	CombatDetail.coin = int(0)
	CombatDetail.gem = int(0)
