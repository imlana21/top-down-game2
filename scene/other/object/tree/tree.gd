extends CharacterBody2D

var hp: int = 8
var is_near_player = false

func _ready():
	$ProgressBar.max_value = hp
	$ProgressBar.min_value = 0
	$ProgressBar.visible = false
	$DestroyAnimation.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("attack") and is_near_player:
		hp -= 1
	hp_update()
	
func _on_tree_area_body_entered(body):
	$ProgressBar.visible = true
	is_near_player = true

func _on_tree_area_body_exited(body):
	$ProgressBar.visible = false
	is_near_player = false

func hp_update():
	$ProgressBar.value = hp
	if hp < 1:
		$DestroyAnimation.visible = true
		$DestroyAnimation.play("destroy")
		$TreeSprite.visible = false

func _on_destroy_animation_finished():
	var wood = load("res://scene/other/items/wood/wood.tscn").instantiate()
	wood.global_position = get_global_position()
	wood.scale = Vector2(0.8, 0.8)
	Autoload.world.add_child(wood)
	count_down_spawn()
	queue_free()

func count_down_spawn():
	var countdown_instance = load("res://scene/enemies/countdown_spawner.tscn").instantiate()
	countdown_instance.spawn_position = get_global_position()
	countdown_instance.MAX_TIME = 20
	countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_tree)
	Autoload.scene_manager.add_child(countdown_instance)



