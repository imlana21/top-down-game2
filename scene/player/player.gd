extends CharacterBody2D

const PLAYER_SPEED = 100

signal change_direction
signal change_velocity
signal change_attack

func _init():
	Autoload.player = self
	
func _process(delta):
	# Stop walk while player attack
	if Autoload.is_attacking:
		return
	
func _physics_process(delta):
	if Autoload.is_attacking == false:
		walk()

func _input(event):
	if event is InputEventKey and event.pressed:
		change_direction.emit(vector_movement())
	elif event is InputEventMouseButton and event.pressed:
		change_attack.emit(Autoload.deg_mouse_position(self))
		
# if WASD pressed, read as vector
func vector_movement():
	var left = Input.is_action_pressed("walk_left")
	var right = Input.is_action_pressed("walk_right")
	var up = Input.is_action_pressed("walk_up")
	var down = Input.is_action_pressed("walk_down")
	
	# Convert input to vector and return it
	return Vector2(-int(left)+int(right),-int(up)+int(down))

func walk():
	var walk_movement = Vector2()
	walk_movement += vector_movement()
	set_velocity(walk_movement * PLAYER_SPEED)
	change_velocity.emit(velocity.length())
	velocity = velocity
	move_and_slide()
	
