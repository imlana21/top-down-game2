extends NPC

func _ready():
	$Sprite.play("idle")
	$WaitTimer.wait_time = wait_time
	$MoveTimer.wait_time = move_time
	$MoveTimer.start()

func _physics_process(delta):
	if move_state:
		move_and_collide(move_direction * delta * move_speed)

func _on_move_timer_timeout():
	move_state = true
	move_direction = random_move()
	move_animation(move_direction, $Sprite)
	$WaitTimer.start()

func _on_wait_timer_timeout():
	move_state = false
	$Sprite.play("idle")
	$MoveTimer.start()
