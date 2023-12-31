extends CharacterBody2D

const PLAYER_SPEED = 6000
var CHAR_DETAIL = {
	"atk_speed": 0.6,
	"max_hp": 50,
	"curr_hp": 50,
	"luk": 0.5,
	"def": 1,
	"str": 3
}

signal change_direction
signal change_velocity
signal start_combat
signal change_attack

func _init():
	Autoload.player = self
	CombatDetail.player_detail = CHAR_DETAIL
	if CombatDetail.last_position != null and !CombatDetail.is_attacking:
		position = CombatDetail.last_position
		CombatDetail.last_position = null

func _process(_delta):
	if Autoload.player_skin == "red":
		$PlayerSprite.modulate = "ff0000"
	else:
		$PlayerSprite.modulate = "ffffff"
	
func _physics_process(delta):
	if CombatDetail.is_attacking == false:
		walk(delta)

func _input(event):
	if event is InputEventKey and event.pressed:
		change_direction.emit(get_axis_input())

func _on_enemy_detector_body_entered(body):
	if CombatDetail.is_attacking == false and CombatDetail.player_energy > 0:
		CombatDetail.last_position = position
		start_combat.emit(body)
		CombatDetail.is_attacking = true

# if WASD pressed, read as vector
func get_axis_input():
	var axis = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	axis.x = int(Input.is_action_pressed("walk_right"))-int(Input.is_action_pressed("walk_left"))
	axis.y = int(Input.is_action_pressed("walk_down"))-int(Input.is_action_pressed("walk_up"))
	# Convert input to vector and return it
	return axis.normalized()

func walk(delta):
	var speed = 0
	if Input.is_action_pressed("run"):
		speed = PLAYER_SPEED + 500
	else:
		speed = PLAYER_SPEED/2
		
	var walk_movement = get_axis_input()
	set_velocity(walk_movement * speed * delta)
	change_velocity.emit(velocity.length())
	move_and_slide()

func take_damage(strength):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - strength 

func attacking():
	change_attack.emit()
