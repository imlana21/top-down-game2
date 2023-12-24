extends Node2D

var next_scene = null
var current_scene = null
var last_enemy = null

@onready var anim_trans = $ScreenTransition/AnimationTransition
@onready var combat_scene = preload("res://scene/combat/battle_combat.tscn")

func _ready():
	$PauseLayer/Pause.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		$PauseLayer/Pause.z_index = 10
		$PauseLayer/Pause.scale = Autoload.pause_scale
		$PauseLayer/Pause.position = Autoload.pause_position
		Autoload.pause_game($PauseLayer/Pause)

func _on_change_scene(next_path, current):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	current_scene = current
	anim_trans.play("fade_in")

func _on_player_start_combat(current_world, enemy):
	if last_enemy == null:
		last_enemy = str(enemy.name)
	current_scene = current_world
	next_scene = combat_scene.instantiate()
	next_scene.connect("change_scene", _on_player_finish_combat)
	anim_trans.play("fade_in")

func _on_player_finish_combat(next_path, current_world):
	current_scene = current_world
	next_scene = load(next_path).instantiate()
	next_scene.connect("start_combat", _on_player_start_combat)
	next_scene.remove_child(next_scene.get_node(last_enemy))
	anim_trans.play("fade_in")
	
func _on_animation_transition_finished(anim_name):
	match anim_name:
		"fade_in":
			current_scene.queue_free()
			anim_trans.play("fade_out")
		"fade_out":
			add_child(next_scene)
			current_scene = next_scene
			next_scene = null
