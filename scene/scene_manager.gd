extends Node2D

var next_scene = null
var current_scene = null
var player_point = null

@export var MAX_ENEMY = 5

@onready var anim_trans = $ScreenTransition/AnimationTransition
@onready var combat_scene = preload("res://scene/combat/battle_combat.tscn")
@onready var countdown_spawn = preload("res://scene/enemies/countdown_spawner.tscn")

func _ready():
	Autoload.scene_manager = self
	$PauseLayer/Pause.hide()
	$ChangeSkinLayer/SkinMenu.hide()
	Autoload.world.connect("change_scene", _on_change_scene)
	Autoload.world.connect("start_combat", _on_player_start_combat)
	
func _on_timeout_spawn_enemy(pos):
	var random_pos = Autoload.random_position()
	print("Enemy spawn in position ", random_pos)
	Autoload.enemy_position.append(random_pos)
	Autoload.spawn_enemy(Autoload.world, random_pos)

func _on_timeout_spawn_ore(pos):
	var world_cave = WorldCave.new()
	world_cave = world_cave.get_random_cave_position()
	if Autoload.world.name == 'Cave':
		print("Ore spawn in position ", world_cave)
		Autoload.spawn_ore(Autoload.world, world_cave)
	else:
		Autoload.ore_position.append(world_cave)
	
func _on_timeout_spawn_tree(pos):
	var random_pos = Autoload.random_position()
	if Autoload.world.name == 'World':
		print("Tree spawn in position ", pos)
		Autoload.spawn_tree(Autoload.world, random_pos)
	else:
		Autoload.tree_position.append(pos)
	
func _on_change_scene(next_path, current, player_pos):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	next_scene.connect("start_combat", _on_player_start_combat)
	current_scene = current
	player_point = player_pos
	anim_trans.play("fade_in")

func _on_player_start_combat(current_world):	
	print("StartCombat")
	current_scene = current_world
	next_scene = combat_scene.instantiate()
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


