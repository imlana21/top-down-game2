extends NPC

func _ready():
	$Sprite.play("idle")

func _physics_process(delta):
	if move_state:
		velocity += move_direction
		move_and_slide()
		
func _on_auto_move_timer_timeout():
	move_state = !move_state
	move_direction = random_move()
