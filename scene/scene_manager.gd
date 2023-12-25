extends Node2D

var next_scene = null
var current_scene = null
var last_enemy = null

@export var MAX_ENEMY = 5

@onready var anim_trans = $ScreenTransition/AnimationTransition
@onready var combat_scene = preload("res://scene/combat/battle_combat.tscn")
@onready var loading_scene = preload("res://scene/menu/loading_screen/loading_screen.tscn")
@onready var countdown_spawn = preload("res://scene/enemies/countdown_spawner.tscn")

func _ready():
	Autoload.scene_manager = self
	$PauseLayer/Pause.hide()
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		$PauseLayer/Pause.z_index = 10
		$PauseLayer/Pause.scale = Autoload.pause_scale
		$PauseLayer/Pause.position = Autoload.pause_position
		Autoload.pause_game($PauseLayer/Pause)
	
func _on_timeout_spawn_enemy():
	var random_pos = Autoload.random_position(Autoload.world)
	print("Enemy muncul di ", random_pos)
	Autoload.enemy_position.append(random_pos)
	Autoload.spawn_enemy(Autoload.world, random_pos)	
	
func _on_change_scene(next_path, current):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	current_scene = current
	anim_trans.play("fade_in")

func _on_player_start_combat(current_world, enemy):	
	current_scene = current_world
	next_scene = combat_scene.instantiate()
	next_scene.connect("change_scene", _on_player_finish_combat)
	anim_trans.play("fade_in")

func _on_player_finish_combat(next_path, current_world):
	current_scene = current_world
	next_scene = load(next_path).instantiate()
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
	var loading_instance = loading_scene.instantiate()
	loading_instance.connect("start_combat", _on_loader_start_combat)
	add_child(loading_instance)
	
func _on_loader_start_combat():
	$CurrentScene.add_child(next_scene)
	current_scene = next_scene
	next_scene = null
	
