extends CharacterBody2D

const PLAYER_SPEED = 1500

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
		walk(delta)

func _input(event):
	if event is InputEventKey and event.pressed:
		change_direction.emit(get_axis_input())
	elif event is InputEventMouseButton and event.pressed:
		change_attack.emit(Autoload.deg_mouse_position(self))
		
# if WASD pressed, read as vector
func get_axis_input():
	var axis = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	axis.x = int(Input.is_action_pressed("walk_right"))-int(Input.is_action_pressed("walk_left"))
	axis.y = int(Input.is_action_pressed("walk_down"))-int(Input.is_action_pressed("walk_up"))
	# Convert input to vector and return it
	return axis.normalized()

func walk(delta):
	var walk_movement = get_axis_input()
	set_velocity(walk_movement * PLAYER_SPEED * delta)
	change_velocity.emit(velocity.length())
	move_and_slide()
	
	
	
