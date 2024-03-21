class_name Player
extends CharacterBody2D

const PLAYER_SPEED = 6000
var CHAR_DETAIL = {
	"atk_speed": 0.6,
	"max_hp": 50,
	"curr_hp": 50,
	"luk": 0.5,
	"def": 1,
	"str": 3,
	"exp": 0,
	"level": 1
}
signal change_direction
signal change_velocity
signal start_combat
signal player_hit

func _init():
	Autoload.player = self
	if CombatDetail.player_detail == {}:
		CombatDetail.player_detail = CHAR_DETAIL
	
func _ready():
	if Autoload.paused_on != "":
		return
	if CombatDetail.last_position != null and !CombatDetail.is_attacking:
		position = CombatDetail.last_position
		CombatDetail.last_position = null

func _process(_delta):
	if Autoload.paused_on != "":
		return
	if Autoload.player_skin == "red":
		$PlayerSprite.modulate = "ff0000"
	else:
		$PlayerSprite.modulate = "ffffff"
	
func _physics_process(delta):
	if Autoload.paused_on != "":
		change_direction.emit(Vector2(0, 1))
		return
	if !CombatDetail.is_attacking and !Autoload.is_spectator_mode:
		walk(delta)

func _input(event):
	if Autoload.paused_on != "":
		return
	if event is InputEventKey and event.pressed and !Autoload.is_spectator_mode:
		change_direction.emit(get_axis_input())

func _on_enemy_detector_body_entered(body):
	if !body.is_in_group("enemy"):
		return
	if Autoload.world != null and Autoload.world.name == "WarpWorld":
		CombatDetail.last_position = position
		start_combat.emit(body)
		CombatDetail.is_attacking = true
	elif CombatDetail.is_attacking == false and CombatDetail.player_energy > 0:
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
	player_hit.emit()
