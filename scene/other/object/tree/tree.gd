extends CharacterBody2D

var hp: int = 8
var is_near_player = false
var first_time = true
var current_position = Vector2.ZERO
var current_dropped = 3

signal drop_item

func _ready():
	$ProgressBar.max_value = hp
	$ProgressBar.min_value = 0
	$ProgressBar.visible = false
	$DestroyAnimation.visible = false
	$DroppedItemTimer.wait_time = randi_range(1, 3)
	$DroppedItemTimer.start()
	current_position = get_global_position() + Vector2(10, 23)
	
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
	countdown_instance.spawn_position = Autoload.random_position()
	countdown_instance.MAX_TIME = 2
	countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_tree)
	Autoload.scene_manager.add_child(countdown_instance)

func _on_dropped_item_timer_timeout():
	if first_time:
		$DroppedItemTimer.wait_time = 5
		$DroppedItemTimer.start()
		first_time = false
	elif current_dropped > 0:
		drop_item.emit(self)
		current_position += Vector2(randi_range(-10, -4), randi_range(-2, -1))
		current_dropped -= 1
		$DroppedItemTimer.start()
		
	if current_dropped < 1:
		$TreeSprite.play("empty")
		$DroppedItemTimer.stop()
