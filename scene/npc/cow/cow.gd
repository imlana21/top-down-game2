extends NPC

var hp: int = 4
var in_attack_zone: bool = false
var is_player_near: bool = false
var action: String = "fast"

func _ready():
	auto_movement_init()
	progressbar_init()

func _physics_process(delta):
	if move_state:
		move_and_collide(move_direction * delta * move_speed)
	if Input.is_action_just_pressed("attack") and in_attack_zone:
		hp -= 1
	hp_update()

func hp_update():
	$ProgressBar.value = hp
	if hp < 1:
		$DestroyAnimation.play("destroy")
		$Sprite.visible = false
		move_state = false

func _on_destroy_animation_finished():
	var meat_pos = get_global_position()
	var meat = load("res://scene/other/items/raw_meat/raw_meat.tscn").instantiate()
	meat.scale = Vector2(0.4, 0.4)
	meat.global_position = meat_pos
	Autoload.world.add_child(meat)
	
	var leather_pos = meat_pos - Vector2(10, 0)
	var leather = load("res://scene/other/items/leather/leather.tscn").instantiate()
	leather.scale = Vector2(0.4, 0.4)
	leather.global_position = leather_pos
	Autoload.world.add_child(leather)
		
	queue_free()

# ProgressBar Controller
func progressbar_init():
	$ProgressBar.max_value = hp
	$ProgressBar.min_value = 0
	$ProgressBar.visible = false
	
func _on_attack_detector_body_entered(body):
	$ProgressBar.visible = true
	in_attack_zone = true

func _on_attack_detector_body_exited(body):
	$ProgressBar.visible = false
	in_attack_zone = false
	
# Auto Movement
func auto_movement_init():
	$WaitTimer.wait_time = wait_time
	$MoveTimer.wait_time = move_time
	$WaitTimer.start()
	
func _on_move_timer_timeout():
	move_state = true
	speed_order()
	move_direction = random_move()
	move_animation(move_direction, $Sprite)
	$WaitTimer.start()

func speed_order():
	match action:
		"fast":
			move_time = 0.6
			move_speed = 50
			action = "medium"
		"medium":
			move_time = 0.45
			move_speed = 30
			action = "normal"
		_:
			move_time = 0.3
			move_speed = 10
			action = "fast"

func _on_wait_timer_timeout():
	move_state = false
	$Sprite.play("idle")
	$MoveTimer.start()

func _on_enemy_detector_body_entered(body):
	is_player_near = true
