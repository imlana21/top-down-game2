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
	
func _process(_delta):
	pause_menu()
	skin_menu()
	
func pause_menu():
	if Input.is_action_just_pressed("pause"):
		$PauseLayer/Pause.z_index = 10
		$PauseLayer/Pause.scale = Autoload.pause_scale
		$PauseLayer/Pause.position = Autoload.pause_position
		Autoload.pause_game($PauseLayer/Pause)

func skin_menu():
	if Input.is_action_just_pressed("change_skin"):
		$ChangeSkinLayer/SkinMenu.z_index = 10
		$ChangeSkinLayer/SkinMenu.scale = Autoload.pause_scale
		$ChangeSkinLayer/SkinMenu.position = Autoload.pause_position
		Autoload.pause_game($ChangeSkinLayer/SkinMenu)
	
func _on_timeout_spawn_enemy():
	var random_pos = Autoload.random_position()
	print("Enemy spawn in position ", random_pos)
	Autoload.enemy_position.append(random_pos)
	Autoload.spawn_enemy(Autoload.world, random_pos)	
	
func _on_change_scene(next_path, current, player_pos):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	next_scene.connect("start_combat", _on_player_start_combat)
	current_scene = current
	player_point = player_pos
	anim_trans.play("fade_in")

func _on_player_start_combat(current_world):	
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

func start_fade_in():
	current_scene.queue_free()
	anim_trans.play("fade_out")

func start_fade_out():
	_on_loader_start_combat()
	if player_point != null:
		Autoload.player.position = Autoload.enter_world_position[player_point]
	player_point = null
	
func _on_loader_start_combat():
	$CurrentScene.add_child(next_scene)
	current_scene = next_scene
	next_scene = null
	
