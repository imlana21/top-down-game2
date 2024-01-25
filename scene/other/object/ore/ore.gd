extends CharacterBody2D

var hp: int = 8
var is_near_player = false

func _ready():
	$ProgressBar.max_value = hp
	$ProgressBar.min_value = 0
	$ProgressBar.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("attack") and is_near_player:
		hp -= 1
	hp_update()

func _on_ore_area_body_entered(body):
		$ProgressBar.visible = true
		is_near_player = true

func _on_ore_area_body_exited(body):
	$ProgressBar.visible = false
	is_near_player = false
	
func hp_update():
	$ProgressBar.value = hp
	if hp < 1:
		$DestroyAnimation.play("destroy")
		$RockAnimation.visible = false

func _on_destroy_animation_finished():
	var ore = load("res://scene/other/items/ore/Ore.tscn").instantiate()
	ore.global_position = get_global_position()
	Autoload.world.add_child(ore)
	
	var countdown_instance = load("res://scene/enemies/countdown_spawner.tscn").instantiate()
	countdown_instance.MAX_TIME = 3
	countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_ore)
	Autoload.scene_manager.add_child(countdown_instance)
	
	queue_free()
